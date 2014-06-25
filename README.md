The following commands are suggested in an environment setup in order to support the postgis adapter:

sudo apt-get install libjson0
sudo apt-get install libjsoncpp-dev
sudo apt-get install libxml2-dev
sudo apt-get install libgdal-ruby
sudo apt-get install libproj-dev
sudo apt-get install libgeo-proj4-perl
sudo apt-get install libgeos-dev

Note: make sure you get geos 3.3.0 or higher. You may need to compile from source.
TODO: Write out the commands necessary to pull the tarball and compile it. Tarball url is "http://download.osgeo.org/geos/geos-3.4.2.tar.bz2"
Note: make sure you get gdal 1.8.0 or higher. You may need to compile from source.
TODO: Write out the commands necessary to pull the tarball and compile it. Tarball url is "http://download.osgeo.org/gdal/1.11.0/gdal-1.11.0.tar.gz"

To get the postgis extension, use the following (assuming you're using postgresql version 9.1):
sudo apt-get install postgresql-9.1-postgis




TODO: For models using rgeo-based spatial data, the documentation suggests the following sort of configuration. Should probably do this some time soon: 

class MySpatialTable < ActiveRecord::Base

  # By default, use the GEOS implementation for spatial columns.
  self.rgeo_factory_generator = RGeo::Geos.factory_generator

  # But use a geographic implementation for the :lonlat column.
  set_rgeo_factory_for_column(:lonlat, RGeo::Geographic.spherical_factory(:srid => 4326))

end