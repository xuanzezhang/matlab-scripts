clc;
clear;
out_path='G:\xzhang\PMLV2-MODIS-PRODUCT\PMLV2_MODIS_8D_0.05deg\';
file_path='G:\xzhang\PMLV2-MODIS-PRODUCT\PMLV2_005deg_2002-2005\';
file_list = dir(strcat(file_path,'*.tif'));%��ȡ���ļ���������TIF��ʽ��ͼ�� 
nfile = length(file_list);%��ȡͼ��������
if nfile > 0
    for jj = 2:nfile
        in_file_name = file_list(jj).name;% ͼ����
        in_file=strcat(file_path,in_file_name);
        [image,geo] = geotiffread(in_file); 
        fprintf(' %d %s\n',jj,in_file);% ��ʾ���ڴ����ͼ����
        
        file_name=strsplit(file_list(jj).name,'.')
        out_file_name=char(file_name(1))
        out_file = strcat(out_file_name,'.nc');%·���µ��ļ���
        fprintf(' %d %s\n',jj,out_file);% ��ʾ���ڴ����ͼ����
        % 0. ��ȡ����ά��
        ndim=size(image);
        nlat=ndim(1);
        nlon=ndim(2);
        lat=linspace(-60,90,nlat);
        lat=fliplr(lat);  % �����Ǵ�90 �� -60 ���е�
        lon=linspace(-180,180,nlon);
        
        GPP=single(image(:,:,1))*0.01;
        Ec=single(image(:,:,1))*0.01;
        Es=single(image(:,:,1))*0.01;
        Ei=single(image(:,:,1))*0.01;
        ET_water=single(image(:,:,1))*0.01;
        ET=Ec+Es+Ei+ET_water;
        
        delete(out_file);
        nccreate(out_file,'lat',...
            'Dimensions', {'lat',nlat},...
            'FillValue','disable');  
        nccreate(out_file,'lon',...
            'Dimensions', {'lon',nlon},...
            'FillValue','disable');  
        nccreate(out_file,'GPP',...
            'Dimensions', {'lat',nlat,'lon',nlon},...
            'FillValue','disable');
        nccreate(out_file,'ET',...
            'Dimensions', {'lat',nlat,'lon',nlon},...
            'FillValue','disable');  
        nccreate(out_file,'Ec',...
            'Dimensions', {'lat',nlat,'lon',nlon},...
            'FillValue','disable');  
        nccreate(out_file,'Es',...
            'Dimensions', {'lat',nlat,'lon',nlon},...
            'FillValue','disable');  
        nccreate(out_file,'Ei',...
            'Dimensions', {'lat',nlat,'lon',nlon},...
            'FillValue','disable');  
        nccreate(out_file,'ET_water',...
            'Dimensions', {'lat',nlat,'lon',nlon},...
            'FillValue','disable');
        
        ncwriteatt(out_file,'lat','units','degree_north');
        ncwriteatt(out_file,'lon','units','degree_east');
        ncwriteatt(out_file,'GPP','units','gC m-2 d-1');
        ncwriteatt(out_file,'ET','units','mm d-1');
        ncwriteatt(out_file,'Ec','units','mm d-1');
        ncwriteatt(out_file,'Es','units','mm d-1');
        ncwriteatt(out_file,'Ei','units','mm d-1');
        ncwriteatt(out_file,'ET_water','units','mm d-1');
        
        ncwrite(out_file,'lat',lat);
        ncwrite(out_file,'lon',lon);
        ncwrite(out_file,'GPP',GPP);
        ncwrite(out_file,'ET',Ec);
        ncwrite(out_file,'Ec',Ec);
        ncwrite(out_file,'Es',Es);
        ncwrite(out_file,'Ei',Ei);
        ncwrite(out_file,'ET_water',ET_water);
%         
%         % 1.����nc�ļ�
%         % cid = netcdf.create(filename, mode)
%         % mode��
%         % 'NC_NOCLOBBER'��           Prevent overwriting of existing file with the same name.
%         % 'NC_SHARE'��               Allow synchronous file updates.
%         % 'NC_64BIT_OFFSET'��        Allow easier creation of files and variables which are larger than two gigabytes.
%         ncid = netcdf.create(out_file,'NC_NOCLOBBER');
%         % 2.����Dimension
%         % dimid = netcdf.defDim(ncid,dimname,dimlen)
%         dimidx = netcdf.defDim(ncid,'lon',nlon);
%         dimidy = netcdf.defDim(ncid,'lat',nlat);
%         
%         % 3.�������
%         % varid = netcdf.defVar(ncid,varname,xtype,dimids);
%         lon_id = netcdf.defVar(ncid,'lon','double',[dimidx]);
%         lat_id = netcdf.defVar(ncid,'lat','double',[dimidy]);
%         var1_id = netcdf.defVar(ncid,'GPP','double',[dimidx dimidy]);
%         var2_id = netcdf.defVar(ncid,'Ec','double',[dimidx dimidy]);
%         var3_id = netcdf.defVar(ncid,'Es','double',[dimidx dimidy]);
%         var4_id = netcdf.defVar(ncid,'Ei','double',[dimidx dimidy]);
%         var5_id = netcdf.defVar(ncid,'ET_water','double',[dimidx dimidy]);
% 
%         % 4.���netCDF�ļ�����ģʽ
%         netcdf.endDef(ncid);
%         
%         % 5. ������д��netcdf���ļ���
%         % netcdf.putVar(ncid,varid,data)
%         % netcdf.putVar(ncid,varid,start,data)
%         % netcdf.putVar(ncid,varid,start,count,data)
%         % netcdf.putVar(ncid,varid,start,count,stride,data)
%         netcdf.putVar(ncid,lat_id,lat);
%         netcdf.putVar(ncid,lon_id,lon);
%         netcdf.putVar(ncid,var1_id,GPP);
%         netcdf.putVar(ncid,var2_id,Ec);
%         netcdf.putVar(ncid,var3_id,Es);
%         netcdf.putVar(ncid,var4_id,Ei);
%         netcdf.putVar(ncid,var5_id,ET_water);
%         
%         %6. �ر��ļ�
%         netcdf.close(ncid);
    end
end








