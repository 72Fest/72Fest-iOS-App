(function () {
    function formatTimeValue(val) {
        return (val < 10) ? "0" + val : val;
    }

    //backbone model
    var CountdownModel = Backbone.Model.extend({
        urlRoot: '/photoapp/countDown.php',
        defaults: {
            caption: "",
            time: "",
            remainingTime: ""
        },
        initialize: function () {
            this.on("change", function (model) {
                //alert("model aption:" + model.get("caption"));
            });
        },
        startTimer: function (model) {
            //calc the time left
            
            var t = model.get("time"), //retrieve the end time
            	timeLeft = {},
            	endDate = new Date(t.year, t.month - 1, t.day, t.hour, t.minute, t.second),
                timeDiff,
                curSecs,
            	endSecs = endDate.getTime() / 1000,
                secsInMin = 60,
            	secsInHour = secsInMin * 60,
            	secsInDay = secsInHour * 24;

            setInterval(function () {
                var curDate = new Date();
                timeLeft = {};
                curSecs = curDate.getTime() / 1000;
                timeDiff = endSecs - curSecs;

                if (timeDiff <= 0) {
                    //Time has expired, zero everything out
                    timeLeft.day = "00";
                    timeLeft.hour = "00";
                    timeLeft.minute = "00";
                    timeLeft.second = "00";
                } else {
                    //there still is time left, caclulate the difference
                    timeLeft.day = formatTimeValue(Math.floor(timeDiff / secsInDay));
                    timeLeft.hour = formatTimeValue(Math.floor((timeDiff / secsInHour) % 24));
                    timeLeft.minute = formatTimeValue(Math.floor((timeDiff / secsInMin) % 60));
                    timeLeft.second = formatTimeValue(Math.floor(timeDiff % secsInMin));
                }
                
                //update the time to trigger the renderer in the view
                model.set({remainingTime: timeLeft});
            }, 1000);
        }
    });

    var countDownModel = new CountdownModel();
    //backbone view
    var CountDownView = Backbone.View.extend({
        model: CountdownModel,
        initialize: function () {
            this.listenTo(this.model, 'change', this.render);
            var self = this;
//                    this.model.on("change", function(m) {
//                        self.render();
//                    });
        },
        render: function () {
            //update label
            $("#countdownLabel").html(this.model.get("caption"));

            var t = this.model.get("remainingTime");
            if (t !== '') {
                //update time
                $("#countdownDayCounter").children(".countdownCounterNumbers").html(t.day);
                $("#countdownHourCounter").children(".countdownCounterNumbers").html(t.hour);
                $("#countdownMinuteCounter").children(".countdownCounterNumbers").html(t.minute);
                $("#countdownSecondCounter").children(".countdownCounterNumbers").html(t.second);
            }
            
        }
    });
    
    var countDownView = new CountDownView({
        model: countDownModel,
        el: $("#countdownContainer")
    });
    
    countDownModel.fetch({
        success: function (dataModel) {
            var timeObj = dataModel.get("time");
            countDownModel.set({
                caption: dataModel.caption,
                time: timeObj
                /*
                year: timeObj.year,
                month: timeObj.month,
                day: timeObj.day,
                hour: timeObj.hour,
                minute: timeObj.minute,
                second: timeObj.second
                */
            });
            
            //we got the date we needed! Start the counter
            dataModel.startTimer(dataModel);
        }
    });
}());
