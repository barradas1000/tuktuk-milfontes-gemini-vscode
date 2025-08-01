import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import iconUrl from 'leaflet/dist/images/marker-icon.png';
import iconRetinaUrl from 'leaflet/dist/images/marker-icon-2x.png';
import shadowUrl from 'leaflet/dist/images/marker-shadow.png';

delete (L.Icon.Default.prototype as any)._getIconUrl;
L.Icon.Default.mergeOptions({
  iconUrl: (iconUrl as any).src || iconUrl,
  iconRetinaUrl: (iconRetinaUrl as any).src || iconRetinaUrl,
  shadowUrl: (shadowUrl as any).src || shadowUrl,
});
L.Icon.Default.imagePath = '';
