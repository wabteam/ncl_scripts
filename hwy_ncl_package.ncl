undef("create_2d_area_wgt_latlon")
function create_2d_area_wgt_latlon(lat:numeric,lon:numeric)
begin
    dlon =   abs(lon(1) - lon(0))
    dlat =   abs(lat(1) - lat(0))
    num_lon =   dimsizes(lon)
    num_lat =   dimsizes(lat)
    area_wgt    =   new((/num_lat,num_lon/),float)
    dx  =   new(num_lat,float)
    dy  =   new(num_lat,float)
    re  =   6.371e6
    rad =   4.0*atan(1.0)/180.0
    do j = 1-1, num_lat-1
        dx(j)   =   doubletofloat(re*cos(lat(j)*rad)*dlon*rad)
        dy(j)   =   doubletofloat(re*abs(dlat)*rad)
    end do
    do j = 1-1, num_lat-1
    do i = 1-1, num_lon-1
        area_wgt(j,i)   =   dx(j)*dy(j)
    end do
    end do
    area_wgt!0  =   "lat"
    area_wgt!1  =   "lon"
    area_wgt&lat    =   lat
    area_wgt&lon    =   lon
    return(area_wgt)
end
