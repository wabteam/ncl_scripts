load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
    mask_fi =   addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")

    in_fi   =   addfile("Hurrell2008_1870-2005_st.nc","r")
    system("rm -rf Hurrell2008_1870-2005_sst.nc")
    sst_fi  =   addfile("Hurrell2008_1870-2005_sst.nc","c")
    system("rm -rf Hurrell2008_1870-2005_lst.nc")
    lst_fi  =   addfile("Hurrell2008_1870-2005_lst.nc","c")

    st      =   in_fi->st
    lat     =   st&lat
    lon     =   st&lon
    time    =   st&time
    land_sea_mask   = mask_fi->LSMASK
    land_sea_mask_with_in_fi_grid = landsea_mask(land_sea_mask,lat,lon)
    
    sst     =   st
    do tt = 0, dimsizes(time)-1
        sst(tt,:,:) = where(land_sea_mask_with_in_fi_grid .lt. 0.5, sst(tt,:,:), sst@_FillValue)
    end do
    sst_fi->sst =   sst 

    lst     =   st
    do tt = 0, dimsizes(time)-1
        lst(tt,:,:) = where(land_sea_mask_with_in_fi_grid .gt. 0.5, lst(tt,:,:), lst@_FillValue)
    end do
    lst_fi->lst =   lst
end
