load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
begin
    wks   = gsn_open_wks ("pdf", "io_sst_prec" )
    gsn_define_colormap(wks,"BlGrYeOrReVi200") 
    data_dir    =   "/public/nfs/9/hwy/indian_ocean_dipole_analysis/data/"
    obs_or_mod  =   "mod"
    start_year  =   1870
    end_year    =   2005 
    ref_year    =   1870 

    var         =   "sst"
    fi_name1    =   "tos_Omon_FGOALS-g2_historical_r1i1p1_187001-200512.nc" 
    fi_name2    =   "tos_Omon_FGOALS-g2_historical_r3i1p1_187001-200512.nc" 
    fi_name3    =   "tos_Omon_FGOALS-g2_historical_r4i1p1_187001-200512.nc" 
    fi_name4    =   "tos_Omon_FGOALS-g2_historical_r5i1p1_187001-200512.nc" 
    fi_name_area     =   "areacello_fx_FGOALS-g2_1pctCO2_r0i0p0.nc"

    var2        =   "pr"
    fi2_name1   =   "pr_Amon_FGOALS-g2_historical_r1i1p1_187001-200512.nc" 
    fi2_name2   =   "pr_Amon_FGOALS-g2_historical_r3i1p1_187001-200512.nc" 
    fi2_name3   =   "pr_Amon_FGOALS-g2_historical_r4i1p1_187001-200512.nc" 
    fi2_name4   =   "pr_Amon_FGOALS-g2_historical_r5i1p1_187001-200512.nc" 

    main_title  =   (/"historical_r1i1p1","historical_r3i1p1","historical_r4i1p1","historical_r5i1p1"/)
    obs_sst_fi_name =   "/public/nfs/9/hwy/indian_ocean_dipole_analysis/data/obs/sst/Hurrell2008_1870-2012_sst.nc"   
    obs_prec_fi_name =   "/public/nfs/9/hwy/indian_ocean_dipole_analysis/data/obs/prec/precip.mon.mean_1979_2010.nc"


    num_time    =   (end_year-start_year+1)*12
    yyyymm      =   new(num_time,integer)

    do year     = start_year, end_year
    do month    = 1, 12
        y_m_i   =   (year-start_year)*12+month-1
        yyyymm(y_m_i)   =   year*100+month
    end do
    end do
    yefrac = yyyymm_to_yyyyfrac(yyyymm, 0.5)
    start_ind   =   (start_year-ref_year)*12
    end_ind     =   (end_year-ref_year)*12+11


    res_cn                  =   True
    res_cn@gsnMaximize      =   True
    res_cn@gsnDraw          = False                  ; turn off draw and frame
    res_cn@gsnFrame         = False                  ; b/c this is an overlay plot
    res_cn@cnFillOn             = True               ; turn on color for contours
    res_cn@cnLinesOn            = False               ; turn off contour lines
    res_cn@cnLineLabelsOn       = False              ; turn off contour line labels
    ;res_cn@gsnScalarContour     = True              ; contours desired
    res_cn@gsnSpreadColors      = True               ; use full color map
    ;res_cn@gsnSpreadColorStart  = 17                ; start at color 17
    res_cn@gsnSpreadColorEnd           = -3  
    ;res_cn@gsnSpreadColorEnd    = 200               ; end at color 200
    res_cn@cnLevelSelectionMode = "ManualLevels"     ; set manual contour levels
    res_cn@cnMinLevelValF       =  16               ; set min contour level
    res_cn@cnMaxLevelValF       =  30               ; set max contour level
    res_cn@cnLevelSpacingF      =  1               ; set contour spacing
    res_cn@cnLineThicknessF     =  1 
    ;res_cn@cnFillMode           =  "CellFill"
    ;res_cn@gsnContourNegLineDashPattern =  1 
    ;res_cn@gsnContourZeroLineThicknessF =  5 
    ;res_cn@cnMinLevelValF       = 60.0               ; set min contour level
    ;res_cn@cnMaxLevelValF       = 240.0                 ; set max contour level
    ;res_cn@cnLevelSpacingF      = 20.0               ; set contour spacing

    res_cn@gsnYAxisIrregular2Linear =   True
    res_cn@gsnXAxisIrregular2Linear =   True
    res_cn@trYMinF   =  -33.0       ; min value on y-axis
    res_cn@trYMaxF   =   33.0       ; max value on y-axis
    res_cn@trXMinF   =   27.0       ; min value on y-axis
    res_cn@trXMaxF   =   133.0      ; max value on y-axis
    res_cn@vpWidthF         = 0.65
    res_cn@vpHeightF        = 0.4


    res_cn@tmXBMode             =   "Explicit"
    res_cn@tmXBMinorOn          =   False
    res_cn@tmXBValues           =   (/30.0,60.0,90.0,120.0/)
    res_cn@tmXBLabels           =   (/"30~F34~0~F~E","60~F34~0~F~E","90~F34~0~F~E","120~F34~0~F~E"/)
    res_cn@tmYLMode             =   "Explicit"
    res_cn@tmYLMinorOn          =   False
    res_cn@tmYLValues           =   (/-30.0,-15.0,0.0,15.0,30.0/)
    res_cn@tmYLLabels           =   (/"30~F34~0~F~S","15~F34~0~F~S","0~F34~0~F~","15~F34~0~F~N","30~F34~0~F~N"/)


    res_cn@tiMainString    =   ""
    res_cn@tiXAxisString   =   ""
    res_cn@tiYAxisString   =   ""
    res_cn@gsnLeftString   =   "units: ~F34~0~F~C"
    res_cn@gsnRightString  =   ""
    res_cn@gsnCenterString =   "" 


    res_cn@tiMainFontHeightF   =   0.035
    res_cn@tiXAxisFontHeightF  =   0.03
    res_cn@tiYAxisFontHeightF  =   0.03
    res_cn@gsnLeftStringFontHeightF    =   0.032
    res_cn@gsnRightStringFontHeightF   =   0.032
    res_cn@gsnCenterStringFontHeightF  =   0.035
    res_cn@tmYLLabelFontHeightF    =   0.028
    res_cn@tmXBLabelFontHeightF    =   0.028
    res_cn@lbLabelBarOn            =   False 
    res_cn@cnInfoLabelOn        =  False 


    res_prec_cn                  =   True
    res_prec_cn@gsnMaximize      =   True
    res_prec_cn@gsnDraw          = False                  ; turn off draw and frame
    res_prec_cn@gsnFrame         = False                  ; b/c this is an overlay plot
    res_prec_cn@cnFillOn             = False               ; turn on color for contours
    res_prec_cn@cnLinesOn            = True               ; turn off contour lines
    res_prec_cn@cnLineLabelsOn       = True              ; turn off contour line labels
    ;res_prec_cn@gsnScalarContour     = True              ; contours desired
    res_prec_cn@gsnSpreadColors      = True               ; use full color map
    ;res_prec_cn@gsnSpreadColorStart  = 17                ; start at color 17
    res_prec_cn@gsnSpreadColorEnd           = -3  
    ;res_prec_cn@gsnSpreadColorEnd    = 200               ; end at color 200
    res_prec_cn@cnLevelSelectionMode = "ManualLevels"     ; set manual contour levels
    res_prec_cn@cnMinLevelValF       =  2                 ; set min contour level
    res_prec_cn@cnMaxLevelValF       =  32                ; set max contour level
    res_prec_cn@cnLevelSpacingF      =  3                 ; set contour spacing
    res_prec_cn@cnLineThicknessF     =  1 
    res_prec_cn@cnLineColor          =  "Black"
    res_prec_cn@cnInfoLabelOn        =  False 
    res_prec_cn@cnLineLabelInterval  =  1 
    res_prec_cn@cnLineLabelPlacementMode    =   "Computed"
    res_prec_cn@cnLineLabelPlacementMode    =   "Randomized"
    res_prec_cn@cnLineLabelDensityF  =  2 
    res_prec_cn@cnLabelMasking = True 
    res_prec_cn@cnLineLabelBackgroundColor  =  -1 
    res_prec_cn@cnLineLabelFontHeightF  =   0.03
    ;res_prec_cn@gsnContourNegLineDashPattern =  1 
    ;res_prec_cn@gsnContourZeroLineThicknessF =  5 
    ;res_prec_cn@cnMinLevelValF       = 60.0               ; set min contour level
    ;res_prec_cn@cnMaxLevelValF       = 240.0                 ; set max contour level
    ;res_prec_cn@cnLevelSpacingF      = 20.0               ; set contour spacing

    res_prec_cn@gsnYAxisIrregular2Linear =   True
    res_prec_cn@gsnXAxisIrregular2Linear =   True
    res_prec_cn@trYMinF   =  -33.0       ; min value on y-axis
    res_prec_cn@trYMaxF   =   33.0       ; max value on y-axis
    res_prec_cn@trXMinF   =   27.0       ; min value on y-axis
    res_prec_cn@trXMaxF   =   133.0      ; max value on y-axis
    res_prec_cn@vpWidthF         = 0.65
    res_prec_cn@vpHeightF        = 0.4


    res_prec_cn@tmXBMode             =   "Explicit"
    res_prec_cn@tmXBMinorOn          =   False
    res_prec_cn@tmXBValues           =   (/30.0,60.0,90.0,120.0/)
    res_prec_cn@tmXBLabels           =   (/"30~F34~0~F~E","60~F34~0~F~E","90~F34~0~F~E","120~F34~0~F~E"/)
    res_prec_cn@tmYLMode             =   "Explicit"
    res_prec_cn@tmYLMinorOn          =   False
    res_prec_cn@tmYLValues           =   (/-30.0,-15.0,0.0,15.0,30.0/)
    res_prec_cn@tmYLLabels           =   (/"30~F34~0~F~S","15~F34~0~F~S","0~F34~0~F~","15~F34~0~F~N","30~F34~0~F~N"/)


    res_prec_cn@tiMainString    =   ""
    res_prec_cn@tiXAxisString   =   ""
    res_prec_cn@tiYAxisString   =   ""
    res_prec_cn@gsnLeftString   =   "" 
    res_prec_cn@gsnRightString  =   "units: mm day~S~-1"
    res_prec_cn@gsnCenterString =   "" 


    res_prec_cn@tiMainFontHeightF   =   0.035
    res_prec_cn@tiXAxisFontHeightF  =   0.03
    res_prec_cn@tiYAxisFontHeightF  =   0.03
    res_prec_cn@gsnLeftStringFontHeightF    =   0.032
    res_prec_cn@gsnRightStringFontHeightF   =   0.032
    res_prec_cn@gsnCenterStringFontHeightF  =   0.035
    res_prec_cn@tmYLLabelFontHeightF    =   0.028
    res_prec_cn@tmXBLabelFontHeightF    =   0.028
    res_prec_cn@lbLabelBarOn            =   True 

    obs_sst_fi  =   addfile(obs_sst_fi_name,"r")
    obs_sst     =   obs_sst_fi->sst(start_ind:end_ind,:,:)
    obs_lon     =   obs_sst&lon
    obs_lat     =   obs_sst&lat
    ref_a    = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")
    ref_lsdata = ref_a->LSMASK
    ref_lsm  = landsea_mask(ref_lsdata,obs_lat,obs_lon)
    do tt   =   0,  dimsizes(obs_sst(:,0,0))-1
        obs_sst(tt,:,:)     =   where(ref_lsm .lt. 0.5, obs_sst(tt,:,:), obs_sst@_FillValue)
    end do

    obs_prec_fi =   addfile(obs_prec_fi_name,"r")
    obs_prec    =   obs_prec_fi->precip(:,:,:)


    fi_ind  =   0
    fi_long_name=   data_dir+obs_or_mod+"/"+var+"/"+fi_name1
    fi          =   addfile(fi_long_name,"r")

    fi2_long_name=   data_dir+obs_or_mod+"/"+var2+"/"+fi2_name1
    fi2          =   addfile(fi2_long_name,"r")

    fi_area_long_name=   data_dir+obs_or_mod+"/"+var+"/"+fi_name_area
    fi_area          =   addfile(fi_area_long_name,"r")

    area_wgt    =   fi_area->areacello
    print("area check")
    print("max of area: " + max(area_wgt))
    print("min of area: " + min(area_wgt))
    print("total area : " + sum(area_wgt))

    
    
        
    season_name =   (/"DJF","MAM","JJA","SON"/)

    plots_cn  =   new(4,graphic)
    plots_cn_obs  =   new(4,graphic)
    plots   =   new(4,graphic)
    plots_obs   =   new(4,graphic)
    do k =  0,  3
        season      =   season_name(k)
        sst         =   month_to_season(clmMonTLL(fi->tos(start_ind:end_ind,:,:)),season)
        sst         =   where(ismissing(sst),sst@_FillValue,sst-273.15)
        pr          =   month_to_season(clmMonTLL(fi2->pr(start_ind:end_ind,:,:)),season)
        pr          =   where(ismissing(pr),pr@_FillValue,pr*86400)
        obs_sst_a   =   month_to_season(clmMonTLL(obs_sst),season)
        obs_sst_a   =   where(ismissing(obs_sst_a),obs_sst_a@_FillValue,obs_sst_a-273.15)
        obs_prec_a  =   month_to_season(clmMonTLL(obs_prec),season)
        lons    =   30.0-2.0 
        lone    =   130.0+2.0
        lats    =   -30.0-2.0
        late    =   30.0+2.0
        io_sst  =   sst(:,{lats:late},{lons:lone})
        io_pr   =   pr(:,{lats:late},{lons:lone})
        io_sst_obs  =   obs_sst_a(:,{lats:late},{lons:lone})
        io_prec_obs  =   obs_prec_a(:,{lats:late},{lons:lone})
        res_cn@tiMainString    =   "Model: "+season 
        plots_cn(k) =   gsn_csm_contour(wks,io_sst(0,::,::),res_cn)
        plots(k)    =   gsn_csm_contour(wks,io_pr(0,::,::),res_prec_cn)
        res_cn@tiMainString    =   "Obs: "+season 
        plots_cn_obs(k) =   gsn_csm_contour(wks,io_sst_obs(0,::,::),res_cn)
        plots_obs(k)    =   gsn_csm_contour(wks,io_prec_obs(0,::,::),res_prec_cn)
        ;plots(k)    =   gsn_csm_vector(wks,tauu_season(0,:,:),tauv_season(0,:,:),res)
        overlay(plots_cn(k),plots(k))
        overlay(plots_cn_obs(k),plots_obs(k))
    end do

    resP    =   True
    resP@gsnMaximize     =   True
    resP@gsnPanelYWhiteSpacePercent = 0.0
    resP@gsnPanelXWhiteSpacePercent = 0.0 
    resP@gsnPaperOrientation = "portrait"
    resP@gsnPanelLabelBar    = True
    resP@pmLabelBarWidthF   = 0.6    ; label bar width
    resP@pmLabelBarHeightF  = 0.05    ; label bar width
    resP@lbLabelFontHeightF = 0.01
    resP@pmLabelBarParallelPosF =   0.01
    plots_final   =   (/plots_cn(0),plots_cn_obs(0),\
                        plots_cn(1),plots_cn_obs(1),\
                        plots_cn(2),plots_cn_obs(2),\
                        plots_cn(3),plots_cn_obs(3)/)
    gsn_panel(wks,plots_final,(/4,2/),resP)

end
