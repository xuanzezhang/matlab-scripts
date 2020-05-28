clc;
clear;
filepath='G:\xzhang\LULCC-Forcing\IGBP_MODIS_0.01deg\2018\landcover_perc_G010_2002-01-01.tif';
info=imfinfo(filepath);
data=imread(filepath);
d=size(data);

% 1.创建nc文件
% cid = netcdf.create(filename, mode)
% mode：
% 'NC_NOCLOBBER'：                Prevent overwriting of existing file with the same name.
% 'NC_SHARE'：                    Allow synchronous file updates.
% 'NC_64BIT_OFFSET'：        Allow easier creation of files and variables which are larger than two gigabytes.
ncid = netcdf.create('landcover_perc_G010_2001-02-01.nc','NC_NOCLOBBER');
% 2.定义Dimension
% dimid = netcdf.defDim(ncid,dimname,dimlen)
dimidx = netcdf.defDim(ncid,'lon',3600);
dimidy = netcdf.defDim(ncid,'lat',1500);
dimidz = netcdf.defDim(ncid,'pft',18);
% 3.定义变量
% varid = netcdf.defVar(ncid,varname,xtype,dimids);
varid = netcdf.defVar(ncid,'landcover_perc','double',[dimidx dimidy dimidz]);

% 4.完成netCDF文件定义模式
netcdf.endDef(ncid);

% 5. 把数据写到netcdf的文件中
% netcdf.putVar(ncid,varid,data)
% netcdf.putVar(ncid,varid,start,data)
% netcdf.putVar(ncid,varid,start,count,data)
% netcdf.putVar(ncid,varid,start,count,stride,data)
netcdf.putVar(ncid,varid,data);

%6. 关闭文件
netcdf.close(ncid);






