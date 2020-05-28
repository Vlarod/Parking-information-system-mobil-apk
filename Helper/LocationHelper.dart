const GOOGLE_API_KEY = 'AIzaSyBdbydVDq6PfmPW3CMNfl8dPyT5RwDlWyQ';

class LocationHelper {
  static String generateLocationPreviewImage(double latitude, double longtitude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtitude&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7Clabel:P%7C$latitude,$longtitude&key=$GOOGLE_API_KEY';
  }
}