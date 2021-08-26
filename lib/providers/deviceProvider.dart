class DeviceProvider{
  String wifiSSID = '', wifiPassword = '', deviceName = '';

  setSsidPassword(String ssid, String password) {
    wifiSSID = ssid;
    wifiPassword = password;
  }

  setDeviceName(String name) {
    deviceName = name;
  }

}