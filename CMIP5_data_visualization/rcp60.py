# -*- coding: utf-8 -*-
"""
Created on Fri Apr 15 14:03:05 2022

@author: Cyrine Chen
"""
import netCDF4
from netCDF4 import num2date
import numpy as np
import os
import pandas as pd
# Récupération des fichiers
paths = []
for root, dirs, files in os.walk("/home/chenaoui/rcp60/tas"):
    for file in files:
        if file.endswith(".nc"):
             s = os.path.join(root, file)
             print(s)
             paths.append(s)
for f in range(len(paths)):
    df = netCDF4.Dataset(paths[f])
    #print(df.__dict__)
    #for dim in df.dimensions.values():
     #   print(dim)
       # for var in df.variables.values():
         #   print(var)
    tas = df['tas'][:]
    tas = df.variables['tas']
    time_dim, lat_dim, lon_dim = tas.get_dims()
    time_var = df.variables[time_dim.name]
    times = num2date(time_var[:], time_var.units)
    latitudes = df.variables[lat_dim.name][:]
    longitudes = df.variables[lon_dim.name][:]
    output_dir = './'
    filename = os.path.join(output_dir, f'tas_day_HadGEM2-AO_rcp60_r1i1p1_20060101-21001230_{f}.csv')
    print(f'Writing data in tabular form to {filename} (this may take some time)...')
    times_grid, latitudes_grid, longitudes_grid = [
    x.flatten() for x in np.meshgrid(times, latitudes, longitudes, indexing='ij')]
    df1 = pd.DataFrame({
        'time': [t.isoformat() for t in times_grid],
        'latitude': latitudes_grid,
        'longitude': longitudes_grid,
        'tas': tas[:].flatten()})
    df1.to_csv(filename, index=False)
    print('Done')
def kelvinToCelsius(kelvin):
    return kelvin - 273.15
# Récupération des fichiers
paths = []
for root, dirs, files in os.walk("/home/chenaoui/rcp60/test"):
    for file in files:
        if file.endswith(".csv"):
             s = os.path.join(root, file)
             print(s)
             paths.append(s)
for f in range(len(paths)):
    df = pd.read_csv(paths[f])
    p1=df.loc[(df['latitude'] <37) & (df['latitude'] >36)]
    p2=p1.loc[(p1['longitude'] <12) &  (p1['longitude']>9)]
    p2['tas_in_C']= kelvinToCelsius(p2['tas'])
    output_dir = './'
    filename = os.path.join(output_dir, f'tas_day_HadGEM2-AO_rcp60_r1i1p1_20060101-21001230_37_12_36_9_{f}.csv')
    print(f'Writing data in tabular form to {filename} (this may take some time)...')
    p2.to_csv(filename, index=False)
    print('Done')  
for f in range(len(paths)):
    df = pd.read_csv(paths[f])
    p1=df.loc[(df['latitude'] <51) & (df['latitude'] >40)]
    p2=p1.loc[(p1['longitude'] <98) &  (p1['longitude']>95)]
    p2['tas_in_C']= kelvinToCelsius(p2['tas'])
    output_dir = './'
    filename = os.path.join(output_dir, f'tas_day_HadGEM2-AO_rcp60_r1i1p1_20060101-21001230_51_98_40_95_{f}.csv')
    print(f'Writing data in tabular form to {filename} (this may take some time)...')
    p2.to_csv(filename, index=False)
    print('Done')
for f in range(len(paths)):
    df = pd.read_csv(paths[f])
    p1=df.loc[(df['latitude'] <14) & (df['latitude'] >13)]
    p2=p1.loc[(p1['longitude'] <14) &  (p1['longitude']>13)]
    p2['tas_in_C']= kelvinToCelsius(p2['tas'])
    output_dir = './'
    filename = os.path.join(output_dir, f'tas_day_HadGEM2-AO_rcp60_r1i1p1_20060101-21001230_14_13_14_13_{f}.csv')
    print(f'Writing data in tabular form to {filename} (this may take some time)...')
    p2.to_csv(filename, index=False)
    print('Done')
