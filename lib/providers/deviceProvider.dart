class DeviceProvider{
  String wifiSSID = '', wifiPassword = '';

  setSsidPassword(String ssid, String password) {
    wifiSSID = ssid;
    wifiPassword = password;
  }

}