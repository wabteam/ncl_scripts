load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "./hwy_ncl_package.ncl"
begin
    obs_dir = "/public/nfs/9/hwy/indian_ocean_dipole_analysis/data/obs/"
    mod_dir = "/public/nfs/9/hwy/indian_ocean_dipole_analysis/data/mod/"

    lons    =   90.0
    lone    =   110.0
    lats    =   -10.0
    late    =   0.0

    obs_sst_finame  =   obs_dir+"sst/WOA2009_tos_monthly_1deg_5m.nc"
    obs_sst_fi      =   addfile(obs_sst_finame,"r")
    sst = obs_sst_fi->tos
    lat = sst&lat
    lon = sst&lon
    area_wgt = create_2d_area_wgt_latlon(lat,lon)
    print(sum(area_wgt))
    obs_sst_month   =   wgt_areaave2(sst(:,{lats:late},{lons:lone}),area_wgt({lats:late},{lons:lone}),0)
    delete(sst)
    delete(lat)
    delete(lon)
    delete(area_wgt)

    obs_Z20_finame  =   obs_dir+"Z20/WOA2009_Z20.nc"
    obs_Z20_fi      =   addfile(obs_Z20_finame,"r")
    Z20 = obs_Z20_fi->Z20
    lat = Z20&lat
    lon = Z20&lon
    area_wgt = create_2d_area_wgt_latlon(lat,lon)
    print(sum(area_wgt))
    obs_Z20_month   =   wgt_areaave2(Z20(:,{lats:late},{lons:lone}),area_wgt({lats:late},{lons:lone}),0)
    delete(Z20)
    delete(lat)
    delete(lon)
    delete(area_wgt)

    obs_olr_finame  =   obs_dir+"olr/olr_1975-2012_ymonavg.nc"
    obs_olr_fi      =   addfile(obs_olr_finame,"r")
    olr = obs_olr_fi->olr
    lat = olr&lat
    lon = olr&lon
    area_wgt = create_2d_area_wgt_latlon(lat,lon)
    print(sum(area_wgt))
    obs_olr_month   =   wgt_areaave2(olr(:,{lats:late},{lons:lone}),area_wgt({lats:late},{lons:lone}),0)
    delete(olr)
    delete(lat)
    delete(lon)
    delete(area_wgt)

    area_wgt_finame =   mod_dir+"sst/areacello_fx_FGOALS-g2_1pctCO2_r0i0p0.nc"
    area_wgt_fi     =   addfile(area_wgt_finame,"r")      
    area_wgt        =   area_wgt_fi->areacello

    mod_sst_finame  =   mod_dir+"sst/tos_Omon_FGOALS-g2_historical_r1i1p1_187001-200512_ymonavg.nc"
    mod_sst_fi      =   addfile(mod_sst_finame,"r")
    sst = mod_sst_fi->tos
    mod_sst_month   =   wgt_areaave2(sst(:,{lats:late},{lons:lone}),area_wgt({lats:late},{lons:lone}),0)
    mod_sst_month   =   mod_sst_month-273.15
    delete(sst)

    mod_Z20_finame  =   mod_dir+"Z20/FGOALS-g2_1870-2005_ymonavg_Z20.nc"
    mod_Z20_fi      =   addfile(mod_Z20_finame,"r")
    Z20 = mod_Z20_fi->Z20
    mod_Z20_month   =   wgt_areaave2(Z20(:,{lats:late},{lons:lone}),area_wgt({lats:late},{lons:lone}),0)
    mod_Z20_month   =   mod_Z20_month
    delete(Z20)
    delete(area_wgt)

    area_wgt_finame =   mod_dir+"olr/areacella_fx_FGOALS-g2_historical_r0i0p0.nc"
    area_wgt_fi     =   addfile(area_wgt_finame,"r")      
    area_wgt        =   area_wgt_fi->areacella

    mod_olr_finame  =   mod_dir+"olr/rlut_Amon_FGOALS-g2_historical_r1i1p1_187001-200512_ymonavg.nc"
    mod_olr_fi      =   addfile(mod_olr_finame,"r")
    mod_olr_fi      =   addfile(mod_olr_finame,"r")
    olr = mod_olr_fi->rlut
    mod_olr_month   =   wgt_areaave2(olr(:,{lats:late},{lons:lone}),area_wgt({lats:late},{lons:lone}),0)
    mod_olr_month   =   mod_olr_month
    delete(olr)
    delete(area_wgt)

    month   =   ispan(1,12,1)
    wks     =   gsn_open_wks("pdf","sst_Z20_olr")

    res   = True
    res@gsnMaximize     =   True
    res@gsnDraw         =   False
    res@gsnFrame        =   False
    res@vpHeightF = 0.3        ; Changes the aspect ratio
    res@vpWidthF  = 0.85
    res@tiMainFontHeightF   =   0.030
    res@tiXAxisFontHeightF  =   0.022
    res@tiYAxisFontHeightF  =   0.02
    res@gsnLeftStringFontHeightF    =   0.025
    res@gsnRightStringFontHeightF   =   0.02
    res@gsnCenterStringFontHeightF  =   0.02
    res@tmYLLabelFontHeightF    =   0.025
    res@tmXBLabelFontHeightF    =   0.025
    res@xyLineThicknessF        =   2.0

    res@tiMainString    =   "" 
    res@tiXAxisString   =   ""
    res@tiYAxisString   =   ""
    res@gsnLeftString   =   ""
    res@gsnRightString  =   ""
    res@gsnCenterString =   ""


    res_sst =   res
    res_sst@trYMinF   =  25        ; min value on y-axis
    res_sst@trYMaxF   =  30        ; max value on y-axis
    res_sst@trXMinF   =  1           ; min value on y-axis
    res_sst@trXMaxF   =  12          ; max value on y-axis
    res_sst@tmXBMode             =   "Explicit"
    res_sst@tmXBMinorOn          =   False 
    res_sst@tmXBValues           =   ispan(1,12,1) 
    res_sst@tmXBLabels           =   (/"J","F","M","A","M","J","J","A","S","O","N","D"/) 
    res_sst@tmYLMode             =   "Explicit"
    res_sst@tmYLMinorOn          =   True 
    res_sst@tmYLMinorValues      =   fspan(25,30,26) 
    res_sst@tmYLValues           =   ispan(25,30,1) 
    res_sst@tmYLLabels           =   (/"25","26","27","28","29","30"/) 
    res_sst@tiMainString    =   "SST" 
    res_sst@gsnLeftString   =   "units: ~F34~0~F~C"

    res_sst@pmLegendDisplayMode     =   "Always"
    res_sst@xyExplicitLegendLabels  =  (/"OBS","FGOALS-g2"/) 
    res_sst@lgPerimOn               =   False      ; No legend perimeter.
    res_sst@pmLegendParallelPosF    =    0.2 
    res_sst@pmLegendOrthogonalPosF  =   -0.8      ; Move closer to plot
    res_sst@pmLegendWidthF          =   0.2
    res_sst@pmLegendHeightF         =   0.1
    res_sst@lgLabelFontHeightF      =   0.02
    res_sst@lgItemOrder             =   (/1,0/)
    plot_sst    =   gsn_csm_xy(wks,month,(/obs_sst_month,mod_sst_month/),res_sst)

    res_Z20 =   res
    res_Z20@trYMinF   =  90        ; min value on y-axis
    res_Z20@trYMaxF   =  120        ; max value on y-axis
    res_Z20@trXMinF   =  1           ; min value on y-axis
    res_Z20@trXMaxF   =  12          ; max value on y-axis
    res_Z20@tmXBMode             =   "Explicit"
    res_Z20@tmXBMinorOn          =   False 
    res_Z20@tmXBValues           =   ispan(1,12,1) 
    res_Z20@tmXBLabels           =   (/"J","F","M","A","M","J","J","A","S","O","N","D"/) 
    res_Z20@tmYLMode             =   "Explicit"
    res_Z20@tmYLMinorOn          =   True 
    res_Z20@tmYLMinorValues      =   fspan(90,120,31) 
    res_Z20@tmYLValues           =   ispan(90,120,5) 
    res_Z20@tmYLLabels           =   (/"90","95","100","105","110","115","120"/) 
    res_Z20@tiMainString    =   "Z20" 
    res_Z20@gsnLeftString   =   "units: m"
    plot_Z20    =   gsn_csm_xy(wks,month,(/obs_Z20_month,mod_Z20_month/),res_Z20)

    res_olr =   res
    res_olr@trYMinF   =  210        ; min value on y-axis
    res_olr@trYMaxF   =  260        ; max value on y-axis
    res_olr@trXMinF   =  1           ; min value on y-axis
    res_olr@trXMaxF   =  12          ; max value on y-axis
    res_olr@tmXBMode             =   "Explicit"
    res_olr@tmXBMinorOn          =   False 
    res_olr@tmXBValues           =   ispan(1,12,1) 
    res_olr@tmXBLabels           =   (/"J","F","M","A","M","J","J","A","S","O","N","D"/) 
    res_olr@tmYLMode             =   "Explicit"
    res_olr@tmYLMinorOn          =   True 
    res_olr@tmYLMinorValues      =   fspan(210,260,26) 
    res_olr@tmYLValues           =   ispan(210,260,10) 
    res_olr@tmYLLabels           =   (/"210","220","230","240","250","260"/) 
    res_olr@tiMainString    =   "OLR" 
    res_olr@gsnLeftString   =   "units: W m~S~-2"
    plot_olr    =   gsn_csm_xy(wks,month,(/obs_olr_month,mod_olr_month/),res_olr)

    resP    =   True
    resP@gsnMaximize     =   True
    resP@gsnPanelYWhiteSpacePercent = 0.0
    resP@gsnPanelXWhiteSpacePercent = 0.0
    resP@gsnPaperOrientation = "portrait"

    plots   =   (/plot_sst,plot_Z20,plot_olr/)
    gsn_panel(wks,plots,(/3,1/),resP)
end
