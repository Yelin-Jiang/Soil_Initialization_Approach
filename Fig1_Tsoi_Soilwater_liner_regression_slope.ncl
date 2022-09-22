;;;;;----------------------------------------------------------------------
;;;;;Created by Yelin Jiang at Sep 30th 2021
;;;;;to test the effect of Amazon temperature on South America
;;;;;----------------------------------------------------------------------
begin
 f_1=addfiles("/glade/scratch/yelinj/paper6/data/h0.tsoi_10cm.mon.long_simulation_1984-2018.nc","r")
 tmp=f_1[:]->TSOI_10CM(:407,:,:)
 tmp_SEP=tmp(8::12,:,:)
 tmp_NOV=tmp(10::12,:,:)

 f_2=addfiles("/glade/scratch/yelinj/paper6/data/h0.soilwater_10cm.mon.long_simulation_1984-2018.nc","r")
 soilwater=f_2[:]->SOILWATER_10CM(:407,:,:)
 soilwater_SEP=soilwater(8::12,:,:)
 soilwater_NOV=soilwater(10::12,:,:)

 SEP_tmp_avg_South_Amazon=dim_avg_n_Wrap(tmp_SEP(:,77:90,228:248),(/1,2/))
 NOV_tmp_avg_South_Amazon=dim_avg_n_Wrap(tmp_NOV(:,77:90,228:248),(/1,2/))
 SEP_soilwater_avg_South_Amazon=dim_avg_n_Wrap(soilwater_SEP(:,77:90,228:248),(/1,2/))
 NOV_soilwater_avg_South_Amazon=dim_avg_n_Wrap(soilwater_NOV(:,77:90,228:248),(/1,2/))

 SEP_tmp_avg_Nordeste=dim_avg_n_Wrap(tmp_SEP(:,77:95,248:261),(/1,2/))
 NOV_tmp_avg_Nordeste=dim_avg_n_Wrap(tmp_NOV(:,77:95,248:261),(/1,2/))
 SEP_soilwater_avg_Nordeste=dim_avg_n_Wrap(soilwater_SEP(:,77:95,248:261),(/1,2/))
 NOV_soilwater_avg_Nordeste=dim_avg_n_Wrap(soilwater_NOV(:,77:95,248:261),(/1,2/))

 SEP_tmp_vs_tmp_South_Amazon=new((/192,288/),"float")
 NOV_tmp_vs_tmp_South_Amazon=new((/192,288/),"float")
 SEP_soilwater_vs_soilwater_South_Amazon=new((/192,288/),"float")
 NOV_soilwater_vs_soilwater_South_Amazon=new((/192,288/),"float")

 SEP_tmp_vs_tmp_Nordeste=new((/192,288/),"float")
 NOV_tmp_vs_tmp_Nordeste=new((/192,288/),"float")
 SEP_soilwater_vs_soilwater_Nordeste=new((/192,288/),"float")
 NOV_soilwater_vs_soilwater_Nordeste=new((/192,288/),"float")

 copy_VarCoords(tmp(0,:,:),SEP_tmp_vs_tmp_South_Amazon)
 copy_VarCoords(tmp(0,:,:),NOV_tmp_vs_tmp_South_Amazon)
 copy_VarCoords(soilwater(0,:,:),SEP_soilwater_vs_soilwater_South_Amazon)
 copy_VarCoords(soilwater(0,:,:),NOV_soilwater_vs_soilwater_South_Amazon)
 copy_VarCoords(tmp(0,:,:),SEP_tmp_vs_tmp_Nordeste)
 copy_VarCoords(tmp(0,:,:),NOV_tmp_vs_tmp_Nordeste)
 copy_VarCoords(soilwater(0,:,:),SEP_soilwater_vs_soilwater_Nordeste)
 copy_VarCoords(soilwater(0,:,:),NOV_soilwater_vs_soilwater_Nordeste)

print("====Do loop begin!====")
  do ilat = 0,191
     do ilon = 0,287

 SEP_tmp_ilat_ilon=new(34,"float");new matrix for each grid point
 SEP_tmp_ilat_ilon=tmp_SEP(:,ilat,ilon)
 SEP_corr_tmp_vs_tmp_ilat_ilon_South_Amazon=regline(SEP_tmp_avg_South_Amazon,SEP_tmp_ilat_ilon)
 SEP_tmp_vs_tmp_South_Amazon(ilat,ilon)=SEP_corr_tmp_vs_tmp_ilat_ilon_South_Amazon
 SEP_corr_tmp_vs_tmp_ilat_ilon_Nordeste=regline(SEP_tmp_avg_Nordeste,SEP_tmp_ilat_ilon)
 SEP_tmp_vs_tmp_Nordeste(ilat,ilon)=SEP_corr_tmp_vs_tmp_ilat_ilon_Nordeste
delete(SEP_corr_tmp_vs_tmp_ilat_ilon_South_Amazon)
delete(SEP_corr_tmp_vs_tmp_ilat_ilon_Nordeste)

 NOV_tmp_ilat_ilon=new(34,"float");new matrix for each grid point
 NOV_tmp_ilat_ilon=tmp_NOV(:,ilat,ilon)
 NOV_corr_tmp_vs_tmp_ilat_ilon_South_Amazon=regline(NOV_tmp_avg_South_Amazon,NOV_tmp_ilat_ilon)
 NOV_tmp_vs_tmp_South_Amazon(ilat,ilon)=NOV_corr_tmp_vs_tmp_ilat_ilon_South_Amazon
 NOV_corr_tmp_vs_tmp_ilat_ilon_Nordeste=regline(NOV_tmp_avg_Nordeste,NOV_tmp_ilat_ilon)
 NOV_tmp_vs_tmp_Nordeste(ilat,ilon)=NOV_corr_tmp_vs_tmp_ilat_ilon_Nordeste
delete(NOV_corr_tmp_vs_tmp_ilat_ilon_South_Amazon)
delete(NOV_corr_tmp_vs_tmp_ilat_ilon_Nordeste)

 SEP_soilwater_ilat_ilon=new(34,"float");new matrix for each grid point
 SEP_soilwater_ilat_ilon=soilwater_SEP(:,ilat,ilon)
 SEP_corr_soilwater_vs_soilwater_ilat_ilon_South_Amazon=regline(SEP_soilwater_avg_South_Amazon,SEP_soilwater_ilat_ilon)
 SEP_soilwater_vs_soilwater_South_Amazon(ilat,ilon)=SEP_corr_soilwater_vs_soilwater_ilat_ilon_South_Amazon
 SEP_corr_soilwater_vs_soilwater_ilat_ilon_Nordeste=regline(SEP_soilwater_avg_Nordeste,SEP_soilwater_ilat_ilon)
 SEP_soilwater_vs_soilwater_Nordeste(ilat,ilon)=SEP_corr_soilwater_vs_soilwater_ilat_ilon_Nordeste
delete(SEP_corr_soilwater_vs_soilwater_ilat_ilon_South_Amazon)
delete(SEP_corr_soilwater_vs_soilwater_ilat_ilon_Nordeste)

 NOV_soilwater_ilat_ilon=new(34,"float");new matrix for each grid point
 NOV_soilwater_ilat_ilon=soilwater_NOV(:,ilat,ilon)
 NOV_corr_soilwater_vs_soilwater_ilat_ilon_South_Amazon=regline(NOV_soilwater_avg_South_Amazon,NOV_soilwater_ilat_ilon)
 NOV_soilwater_vs_soilwater_South_Amazon(ilat,ilon)=NOV_corr_soilwater_vs_soilwater_ilat_ilon_South_Amazon
 NOV_corr_soilwater_vs_soilwater_ilat_ilon_Nordeste=regline(NOV_soilwater_avg_Nordeste,NOV_soilwater_ilat_ilon)
 NOV_soilwater_vs_soilwater_Nordeste(ilat,ilon)=NOV_corr_soilwater_vs_soilwater_ilat_ilon_Nordeste
delete(NOV_corr_soilwater_vs_soilwater_ilat_ilon_South_Amazon)
delete(NOV_corr_soilwater_vs_soilwater_ilat_ilon_Nordeste)

delete(SEP_tmp_ilat_ilon)
delete(NOV_tmp_ilat_ilon)
delete(SEP_soilwater_ilat_ilon)
delete(NOV_soilwater_ilat_ilon)
    end do
   end do
print("====Do loop done!====")
;            SEP_tmp_vs_tmp_South_Amazon(77:90,228:248)=SEP_tmp_vs_tmp_South_Amazon@_FillValue
;SEP_soilwater_vs_soilwater_South_Amazon(77:90,228:248)=SEP_soilwater_vs_soilwater_South_Amazon@_FillValue
;            NOV_tmp_vs_tmp_South_Amazon(77:90,228:248)=NOV_tmp_vs_tmp_South_Amazon@_FillValue
;NOV_soilwater_vs_soilwater_South_Amazon(77:90,228:248)=NOV_soilwater_vs_soilwater_South_Amazon@_FillValue
;            SEP_tmp_vs_tmp_Nordeste(77:95,248:261)=SEP_tmp_vs_tmp_Nordeste@_FillValue
;SEP_soilwater_vs_soilwater_Nordeste(77:95,248:261)=SEP_soilwater_vs_soilwater_Nordeste@_FillValue
;            NOV_tmp_vs_tmp_Nordeste(77:95,248:261)=NOV_tmp_vs_tmp_Nordeste@_FillValue
;NOV_soilwater_vs_soilwater_Nordeste(77:95,248:261)=NOV_soilwater_vs_soilwater_Nordeste@_FillValue

wks  = gsn_open_wks ("x11", "Fig1_Tsoi_Soilwater_liner_regression_slope")

   res                      = True
   res@mpPerimOn              = True                    ; draw box around map
   res@mpGridLineDashPattern  = 2                       ; lat/lon lines as dashed
   res@mpOutlineBoundarySets = "National" ; add state boundaries
   res@mpNationalLineThicknessF = 2
   res@mpGeophysicalLineThicknessF = 2
   res@pmTickMarkDisplayMode = "Always"                 ; turn on tickmarks
   res@mpGridAndLimbOn    = False;True
   res@mpFillOn           = False
   res@mpLimitMode       = "LatLon"            ; choose range of map
;   res@mpMinLatF  = -56;lat2d(0,0)
;   res@mpMinLonF  = -83;lon2d(0,0)
;   res@mpMaxLatF  = 14;lat2d(nlon-1,nlat-1)
;   res@mpMaxLonF  = -33;lon2d(0,nlat-1)
   res@mpMinLatF  = -25;-15;-56;lat2d(0,0)
   res@mpMinLonF  = -83;-55;lon2d(0,0)
   res@mpMaxLatF  = 10;-5;14;lat2d(nlon-1,nlat-1)
   res@mpMaxLonF  = -33;-45;lon2d(0,nlat-1)
   res@gsnDraw =False
   res@gsnFrame=False
   res@cnLevelSelectionMode = "ManualLevels"        ; manual contour levels
   res@cnLevelSpacingF      = 0.25                  ; contour interval
   res@cnMinLevelValF       = -2.0                 ; min level
   res@cnMaxLevelValF       =  2.0                 ; max level
   res@cnLinesOn            = False
   res@cnLineLabelsOn       = False                  ; turn on line labels
   res@cnInfoLabelOn        = False
   res@cnFillOn             = True                  ; turn on color fill
   res@cnFillPalette        = "temp_19lev";"precip4_diff_19lev";"hotcolr_19lev"             ; set color map
   res@lbLabelBarOn         = False
   res@lbOrientation        = "Vertical"
   res@trGridType="TriangularMesh"
   ;res@gsnPresHgtHeightLabelOn =False
   res@gsnLeftString=""
   res@gsnRightString=""
   res@gsnAddCyclic=False
   res@tiYAxisOn=False
   res@tiMainOn=False
res@tmXBLabelFontHeightF                 = 0.02
  res@tmXBLabelFontThicknessF              = 0.07
  res@tmYLLabelFontHeightF                 = 0.02
  res@tmYLLabelFontThicknessF              = 0.07
  plot_1= gsn_csm_contour_map(wks,SEP_tmp_vs_tmp_South_Amazon,res)
  plot_2=gsn_csm_contour_map(wks,NOV_tmp_vs_tmp_South_Amazon,res)
  plot_3= gsn_csm_contour_map(wks,SEP_soilwater_vs_soilwater_South_Amazon,res)
  plot_4=gsn_csm_contour_map(wks,NOV_soilwater_vs_soilwater_South_Amazon,res)
  plot_5= gsn_csm_contour_map(wks,SEP_tmp_vs_tmp_Nordeste,res)
  plot_6=gsn_csm_contour_map(wks,NOV_tmp_vs_tmp_Nordeste,res)
  plot_7= gsn_csm_contour_map(wks,SEP_soilwater_vs_soilwater_Nordeste,res)
  plot_8=gsn_csm_contour_map(wks,NOV_soilwater_vs_soilwater_Nordeste,res)
   gsres                    =True
   gsres@gsLineColor        ="black"
   gsres@gsLineThicknessF   = 3
;lat1 =(/-18,-18,-4,-4,-18/)
;lon1 =(/-76,-49,-49,-76,-76/)
;lat2 =(/-18,-18,1,1,-18/)
;lon2 =(/-51,-33,-33,-51,-51/)
   lat1 =(/-17,-17,-5,-5,-17/)
   lon1 =(/-75,-50,-50,-75,-75/)
   lat2 =(/-17,-17,0,0,-17/)
   lon2 =(/-50,-34,-34,-50,-50/)
  dum1 =gsn_add_polyline(wks,plot_1,lon1,lat1,gsres)
  dum2 =gsn_add_polyline(wks,plot_2,lon1,lat1,gsres)
  dum3 =gsn_add_polyline(wks,plot_3,lon1,lat1,gsres)
  dum4 =gsn_add_polyline(wks,plot_4,lon1,lat1,gsres)

  dum5 =gsn_add_polyline(wks,plot_5,lon2,lat2,gsres)
  dum6 =gsn_add_polyline(wks,plot_6,lon2,lat2,gsres)
  dum7 =gsn_add_polyline(wks,plot_7,lon2,lat2,gsres)
  dum8 =gsn_add_polyline(wks,plot_8,lon2,lat2,gsres)
  plots1=new((/8/),graphic)
   plots1(0)=plot_1
   plots1(1)=plot_5
   plots1(2)=plot_2
   plots1(3)=plot_6
   plots1(4)=plot_3
   plots1(5)=plot_7
   plots1(6)=plot_4
   plots1(7)=plot_8
   resP2=True
  resP2@tiMainFont= 0
  resP2@gsnPanelLabelBar=True
  ;resP2@lbOrientation        = "Vertical"
  resP2@gsnPanelMainString=" "
  resP2@gsnPanelFigureStrings = (/"a1)","a2)","a3)","a4)","b1)","b2)","b3)","b4)"/);,"b4)","b5)","c1)","c2)","c3)","c4)","c5)","d1)","d2)","d3)","d4)","d5)"/)
  resP2@amJust   = "TopRight"
  resP2@gsnPanelFigureStringsFontHeightF = 0.013
  resP2@gsnPanelFigureStringsPerimOn = False
  resP2@gsnFrame=False
  resP2@gsnPanelTop=0.95
  resP2@gsnPanelBottom=0.20
  resP2@gsnPanelLeft=0.1
  resP2@gsnPanelRight=0.9
  resP2@pmLabelBarOrthogonalPosF   = -0.01;1;05 
 gsn_panel(wks,plots1,(/2,4/),resP2)



frame(wks)


end







