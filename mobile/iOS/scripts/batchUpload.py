#!/usr/bin/python

## {{{ based off of python recipe: http://code.activestate.com/recipes/146306/ (r1)
import httplib, mimetypes, urllib, base64, os, argparse

host = "www.lonnygomes.com"
#host = "localhost:31337"
url = "http://www.lonnygomes.com/photoapp/submit.php"
#url = "http://localhost:31337/72fest/submit.php"

def post_multipart(host, selector, fields, key, filename, file):
    content_type, body = encode_multipart_formdata(fields, key, filename, file)
    h = httplib.HTTPConnection(host)
    headers = {
        'User-Agent': 'Python Photo Uploader',
        'Content-Type': content_type
        }

    #body.encode("utf-8")

    h.request('POST', selector, body, headers)
    res = h.getresponse()
    return res.status, res.reason, res.read()


def encode_multipart_formdata(fields, key, filename, value):
    """
    fields is a sequence of (name, value) elements for regular form fields.
    files is a sequence of (name, filename, value) elements for data to be uploaded as files
    Return (content_type, body) ready for httplib.HTTP instance
    """
    BOUNDARY = '----------ThIs_Is_tHe_bouNdaRY_$'
    CRLF = '\r\n'
    L = []
    for (key, value) in fields:
        L.append('--' + BOUNDARY)
        L.append('Content-Disposition: form-data; name="%s"' % key)
        L.append('')
        L.append(value)

    L.append('--' + BOUNDARY)
    L.append('Content-Disposition: form-data; name="%s"; filename="%s"' % (key, "PythonImg.jpg"))
    L.append('Content-Type: %s' % get_content_type(filename))
    L.append('')
    #L.append(unicode(value.read(), "utf-8"))
    L.append(str(value.read()))
    L.append('--' + BOUNDARY + '--')
    L.append('')
    body = CRLF.join(L)
    content_type = 'multipart/form-data; boundary=%s' % BOUNDARY
    return content_type, body

def get_content_type(filename):
    return mimetypes.guess_type(filename)[0] or 'image/jpeg'
## end of http://code.activestate.com/recipes/146306/ }}}


def uploadFromPath(path):
	imageList = os.listdir(path)
	for imageFilename in imageList:
		curImg = os.path.join(path, imageFilename)
		print "Uploading %s ..." % curImg
		
		fd = open(curImg, "r") or die("Cannot open file")
		
		results = post_multipart(host, url, {}, "file", curImg, fd)
		print results
		
		fd.close()
		

#parse command line arguments
parser = argparse.ArgumentParser()
parser.add_argument("imagePath", help="Direcotry with images to batch load")
argv = parser.parse_args()
    
print "Uploading files ..."

uploadFromPath(argv.imagePath)

print "Upload complete!"
