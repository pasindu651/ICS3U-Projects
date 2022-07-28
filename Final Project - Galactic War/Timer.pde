//Timer class
class Timer {
  int startTime, interval, elapsedTime;//Start time, interval, and elapsed time

  //Timer constructor
  Timer(int interval) {//Sets interval
    this.interval = interval;
  }
  //Start method (no return)
  void start() {//Starts timer
    startTime = millis();//Store number of milliseconds since start
  }
  //Finished method (boolean return)
  boolean finished() {//Returns true if time has exceeded given interval
    elapsedTime = millis() - startTime;//Set elapsed time to milliseconds minus start time
    //If elapsed time is greater than interval):
    if (elapsedTime > interval) {
      return true;//Return true
    //If elapsed time is less than or equal to interval:
    } else {
      return false;//Return false
    }
  }
}
