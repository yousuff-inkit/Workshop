<%@page import="com.dashboard.workshop.servicedesk.*" %>
<%ClsWSServiceDeskDAO floordao=new ClsWSServiceDeskDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
</style>
<script type="text/javascript">
var id='<%=id%>';
var floordata=[];
if(id=="1"){
	floordata='<%=floordao.getFloorMgmtData(id,brhid)%>';
}
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value=="undefined" || typeof(value)=="undefined"){
		value="0.00";
	}
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'service' , type: 'string'},
 						{name : 'jobdocno', type: 'number'},
 						{name : 'jobvocno', type:'number'},
 						{name : 'vehicledetails',type:'string'},
 						{name : 'regno',type:'number'},
                      	{name : 'billto', type: 'string'  },
                      	{name : 'refname',type:'string'},
                      	{name : 'jobdate',type:'date'},
                      	{name : 'age',type:'string'},
                      	{name : 'z1',type:'string'},
                      	{name : 'z2',type:'string'},
                      	{name : 'z3',type:'string'},
                      	{name : 'z4',type:'string'},
                      	{name : 'z5',type:'string'},
                      	{name : 'z6',type:'string'},
                      	{name : 'z7',type:'string'},
                      	{name : 'z8',type:'string'},
                      	{name : 'z9',type:'string'},
                      	{name : 'z10',type:'string'},
                      	{name : 'z11',type:'string'},
                      	{name : 'z12',type:'string'},
                      	{name : 'z13',type:'string'},
                      	{name : 'z14',type:'string'},
                      	{name : 'priority',type:'string'},
                      	{name : 'partsstatus',type:'string'},
                      	{name : 'partsexpdate',type:'date'},
                      	{name : 'promiseddate',type:'date'},
                      	{name : 'delindate',type:'date'},
                      	{name : 'extdate',type:'date'},
                      	{name : 'esthrs',type:'number'},
                      	{name : 'actualhrs',type:'number'},
                      	{name : 'hrsdiff',type:'number'},
                      	{name : 'grpname',type:'string'},
                      	{name : 'estimator',type:'string'},
                      	{name : 'srvcadvisor',type:'string'},
                      	{name : 'salesman',type:'string'},
                      	{name : 'insursurvivor',type:'string'},
                      	{name : 'referedby',type:'string'},
                      	{name : 'unattendedstatus',type:'number'},
                      	{name : 'deliverystatus',type:'string'},
                      	{name : 'esttotal',type:'number'}
                      	
             ],
             localdata: floordata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var cellclassname = function (row, column, value, data) {
        	/*if(data.z1.includes("P")){
            	return "redClass";
            }*/
        };
        var cellclassname1 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z1;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z1.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z1.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z1.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname2 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z2;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z2.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z2.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z2.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname3 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z3;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z3.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z3.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z3.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname4 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z4;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z4.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z4.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z4.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname5 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z5;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z5.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z5.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z5.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname6 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z6;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z6.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z6.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z6.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname7 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z7;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z7.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z7.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z7.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname8 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z8;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z8.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z8.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z8.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname9 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z9;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z9.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z9.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z9.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname10 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z10;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z10.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z10.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z10.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname11 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z11;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z11.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z11.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z11.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname12 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z12;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z12.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z12.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z12.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname13 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z13;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z13.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z13.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z13.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var cellclassname14 = function (row, column, value, data) {
        	var cssClassName="";
        	var zonedata=data.z14;
        	if(zonedata!="undefined" && zonedata!="" && zonedata!=null && typeof(zonedata)!="undefined"){
            	cssClassName="yellowClass";
            }
            if(data.z14.includes("C")){
            	cssClassName="greenClass";
            }
            if(data.z14.includes("S")){
            	cssClassName="blueClass";
            }
            if(data.z14.includes("N")){
            	cssClassName="redClass";
            }
            return cssClassName;
        };
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#floorMgmtGrid").jqxGrid(
                {
                	width: '100%',
                    height: 480,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    columnsresize: true,
                    showaggregates:true,
                	showstatusbar:true,
                	enabletooltips:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '3%',pinned:true,cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Job No',datafield: 'jobvocno', width: '3%',pinned:true,cellclassname: cellclassname},
    					{ text: 'Job No',datafield: 'jobdocno', width: '3%',hidden:true,cellclassname: cellclassname},
    					{ text: 'Job Date',datafield: 'jobdate', width: '5%' ,pinned:true,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
    					{ text: 'Vehicle Details',datafield: 'vehicledetails', width: '11%',pinned:true ,cellclassname: cellclassname},
    					{ text: 'Bill To',datafield: 'billto', width: '10%',pinned:true ,cellclassname: cellclassname},
    					{ text: 'Client',datafield: 'refname', width: '10%' ,pinned:true,cellclassname: cellclassname},
    					{ text: 'Age', datafield: 'age', width: '3%',pinned:true,cellclassname: cellclassname},
    					{ text: baynames.z1, datafield: 'z1', width: '4%',cellclassname: cellclassname1,hidden:baynames.z1hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z1count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Waiting" });
                      		}
    					},
    					{ text: baynames.z2, datafield: 'z2', width: '4%',cellclassname: cellclassname2,hidden:baynames.z2hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z2count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Waiting 2" });
                      		}
    					},
    					{ text: baynames.z3, datafield: 'z3', width: '4%',cellclassname: cellclassname3,hidden:baynames.z3hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z3count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Denting" });
                      		}
    					},
    					{ text: baynames.z4, datafield: 'z4', width: '4%',cellclassname: cellclassname4,hidden:baynames.z4hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z4count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Preparation" });
                      		}
    					},
    					{ text: baynames.z5, datafield: 'z5', width: '4%',cellclassname: cellclassname5,hidden:baynames.z5hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z5count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Painting" });
                      		}
    					},
    					{ text: baynames.z6, datafield: 'z6', width: '4%',cellclassname: cellclassname6,hidden:baynames.z6hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z6count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Polish" });
                      		}
    					},
    					{ text: baynames.z7, datafield: 'z7', width: '4%',cellclassname: cellclassname7,hidden:baynames.z7hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z7count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Fit Out" });
                      		}
    					},
    					{ text: baynames.z8, datafield: 'z8', width: '4%',cellclassname: cellclassname8,hidden:baynames.z8hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z8count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Mec Waiting" });
                      		}
    					},
    					{ text: baynames.z9, datafield: 'z9', width: '4%',cellclassname: cellclassname9,hidden:baynames.z9hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z9count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Mechanical" });
                      		}
    					},
    					{ text: baynames.z10, datafield: 'z10', width: '4%',cellclassname: cellclassname10,hidden:baynames.z10hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z10count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Washing" });
                      		}
    					},
    					{ text: baynames.z11, datafield: 'z11', width: '4%',cellclassname: cellclassname11,hidden:baynames.z11hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z11count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "PDI" });
                      		}
    					},
    					{ text: baynames.z12, datafield: 'z12', width: '4%',cellclassname: cellclassname12,hidden:baynames.z12hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z12count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Delivery" });
                      		}
    					},
    					{ text: baynames.z13, datafield: 'z13', width: '4%',cellclassname: cellclassname13,hidden:baynames.z13hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z13count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "Outsource" });
                      		}
    					},
						{ text: baynames.z14, datafield: 'z14', width: '4%',cellclassname: cellclassname14,hidden:baynames.z14hidden,
    						renderer: function (defaultText, alignment, height) {
    							//alert(defaultText+"::"+alignment+"::"+height);
    							var count=$('#z14count').val();
    							if(count==''){
    								count='0';
    							}
        						return '<div style="padding-bottom: 2px; overflow: hidden; text-overflow: ellipsis; text-align: left; margin-left: 4px; margin-right: 2px; margin-bottom: 4px; margin-top: 4px;text-transform:capitalize;">'+defaultText+' ('+count+')</div>';
    						},
    						rendered: function (element) {
                          		$(element).jqxTooltip({ position: 'mouse', content: "QS" });
                      		}
    					},
						{ text: 'Priority', datafield: 'priority', width: '6%',cellclassname: cellclassname},
						{ text: 'Parts Status', datafield: 'partsstatus', width: '8%',cellclassname: cellclassname},
						{ text: 'Parts Exp.Date', datafield: 'partsexpdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Promised Date', datafield: 'promiseddate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Del.In Date', datafield: 'delindate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Extended Date', datafield: 'extdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Est.Hrs', datafield: 'esthrs', width: '5%',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Actual Hrs', datafield: 'actualhrs', width: '5%',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Hrs Diff', datafield: 'hrsdiff', width: '5%',cellclassname: cellclassname,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Est.Total', datafield: 'esttotal', width: '5%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Service',datafield:'service',width: '7%',cellclassname: cellclassname},
						{ text: 'Group', datafield: 'grpname', width: '8%',cellclassname: cellclassname},
						{ text: 'Estimator', datafield: 'estimator', width: '8%',cellclassname: cellclassname},
						{ text: 'Service Advisor', datafield: 'srvcadvisor', width: '8%',cellclassname: cellclassname},
						{ text: 'Salesman', datafield: 'salesman', width: '8%',cellclassname: cellclassname},
						{ text: 'Insurance Survivor', datafield: 'insursurvivor', width: '8%',cellclassname: cellclassname},
						{ text: 'Referred By', datafield: 'referedby', width: '8%',cellclassname: cellclassname},
						{ text: 'Un Attended Status', datafield: 'unattendedstatus', width: '5%',cellclassname: cellclassname,cellsformat:'d2',hidden:true},,
						{ text: 'Reg No', datafield: 'regno', width: '5%',cellclassname: cellclassname,cellsformat:'d',hidden:true},
						{ text: 'Delivery status', datafield: 'deliverystatus', width: '5%',cellclassname: cellclassname,hidden:false},
						
    	              ]
                });

				$('#floorMgmtGrid').on('rowdoubleclick', function (event) 
				{ 
				    var args = event.args;
				    // row's bound index.
				    var boundIndex = event.args.rowindex;
				    // row's visible index.
				    var visibleIndex = event.args.visibleindex;
				    // right click.
				    var rightclick = event.args.rightclick; 
				    // original event.
				    var ev = event.args.originalEvent;
				    
				    $('#jobcarddocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'jobdocno'));
				    $('#jobcardvocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'jobvocno'));
				    getComments();
				    getBays($('#jobcarddocno').val());
				    $('#baymovgriddiv').load('bayMovGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
				    $('#partsdetailsgriddiv').load('partsDetailsGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
				   	$('#jobworkersgriddiv').load('jobWorkersGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
					$('#selectedteamsgriddiv').load('selectedTeamsGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
				   	$('.textpanel p').text('Job Card '+$('#jobcardvocno').val()+' with Reg No '+$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'regno'));
				
				});
	});
</script>
<div id="floorMgmtGrid"></div>