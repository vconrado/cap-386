import psycopg2
import psycopg2.extras
import numpy
import sys
import re
from osgeo import gdal

gdal.AllRegister()

spatial_extent = {'xmin': -89.975, 'ymin': -59.975, 'xmax': -29.975, 'ymax': 10.025, 'xres': 0.05, 'yres': 0.05}
grid_extent = {'xmin': 0, 'ymin': 0, 'xmax': 1199, 'ymax': 1399, 'cols': 1200, 'rows': 1400}

# destination path
base_path = "./tif"


def latlon2grid(spatial_extent, grid_extent, point):
    "Converts a point (lat lon) from a spatial extent to a x,y-coordinates in a grid_extent"
    x = (point['lon'] - spatial_extent['xmin']) / spatial_extent['xres']
    y = grid_extent['ymax'] - (point['lat'] - spatial_extent['ymin']) / spatial_extent['yres']
    return {'x': int(round(x)), 'y': int(round(y))}


try:
    conn = psycopg2.connect(dbname='bdq', user='postgres', host='localhost', port='5433')
except:
    print "I am unable to connect to the database"
    sys.exit(1)

cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

for month in xrange(1, 13):
    print("Gerando imagem do mes {}".format(month))
    c=0
    # create new tiff file
    outfile = "{}/2016_{:02d}_focosraster.tif".format(base_path, month)
    target_ds = gdal.GetDriverByName('GTiff').Create(outfile, grid_extent['cols'], grid_extent['rows'], 1,
                                                     gdal.GDT_UInt16)
    out_band = target_ds.GetRasterBand(1)

    if target_ds is None:
        print "Could not create {}".format(outfile)
        sys.exit(1)

    sql = ("SELECT "
           "ST_AsText(geometria) AS geom, "
           "timestamp as timestamp "
           "FROM focos_bra_2016 "
           "WHERE "
           "EXTRACT(MONTH FROM timestamp) = {} AND "
           "satelite in ('TERRA_M-M', 'TERRA_M-T', 'AQUA_M-T', 'AQUA_M-M');".format(month))

    cursor.execute(sql)

    # POINT(XXX.XXX XXX.XXX)
    pattern = re.compile(r"\((-?\d+\.?\d*) (-?\d+\.?\d*)\)")

    # create empty grid
    out_data = numpy.zeros((grid_extent['rows'], grid_extent['cols']), numpy.int16)
    for foco in cursor:
        c=c+1
        s = re.search(pattern, foco['geom'])
        if s:
            lon_lat = s.groups()
            point = {'lon': float(lon_lat[0]), 'lat': float(lon_lat[1])}
            pos = latlon2grid(spatial_extent, grid_extent, point)
            out_data[pos['y'], pos['x']] += 1;
        else:
            print("Erro ao extrair lon,lat ", foco['geom'])

    out_band.WriteArray(out_data, 0, 0)
    out_band.FlushCache()
    del out_data
    print("Mes {} com {} focos.".format(month, c))

print("Done !")
