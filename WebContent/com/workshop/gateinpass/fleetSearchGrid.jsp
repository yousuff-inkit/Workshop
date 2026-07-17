<%@page import="com.workshop.gateinpass.*" %>
<%ClsGateInPassDAO gatedao=new ClsGateInPassDAO();
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String fleetname=request.getParameter("fleetname")==null?"":request.getParameter("fleetname");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var vehdata;
var id='<%=id%>';
if(id=="1"){
	vehdata='<%=gatedao.getFleet(fleetno,fleetname,regno,date,id)%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'fleet_no', type: 'number'  },
				{name : 'flname', type: 'string'   },
				{name : 'reg_no',type:'number'},
				{name : 'date',type:'date'},
				{name : 'srvckm',type:'number'},
				{name : 'lastsrvckm',type:'number'},
				{name : 'agmtexist',type:'number'},
				{name : 'cldocno',type:'string'},
				{name : 'clientdetails',type:'string'},
				{name : 'agmtno',type:'string'}
          ],
          localdata: vehdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
    			loadComplete: function () {
            		 $("#loadingImage").css("display", "none"); 
        		},
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	            
            }		
    );


            
            
            $("#fleetSearchGrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    /* var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                    
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text:'Fleet No',datafield:'fleet_no',width:'15%'},
							{ text:'Reg No', datafield: 'reg_no', width: '15%' },			
							{ text:'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy'},
							{text: 'Fleet Name',datafield:'flname',width:'47%'},
							{ text: 'Srvc Km',datafield:'srvckm',hidden:true},
							{ text : 'Last Srvc km', datafield:'lastsrvckm',hidden:true},
							{ text : 'Agmt Exist', datafield:'agmtexist',hidden:true},
							{ text : 'Client Doc No', datafield:'cldocno',hidden:true},
							{ text : 'Client Details', datafield:'clientdetails',hidden:true},
							{ text : 'Agmt No', datafield:'agmtno',hidden:true}
			              ]
            });
            
            $("#fleetSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                $('#cldocno,#clientdetails').val('');
				$('#fleetno').val($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'fleet_no'));
				var details="";
				details+=" Reg No :"+$('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'reg_no');
				details+=" Fleet Name : "+$('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'flname');
				$('#fleetdetails').val(details);
				$('#srvckm').val($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'srvckm'));
				$('#lastsrvckm').val($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'lastsrvckm'));
				var srvcdue=parseFloat($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'srvckm'))+parseFloat($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'lastsrvckm'));
				$('#srvcmsg').text('Service Due: '+srvcdue);
				$('#hidsrvcdue').val(srvcdue);
				$('#agmtexist').val($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'agmtexist'));
				if($('#agmtexist').val()=='1'){
					$('#cldocno').val($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'cldocno'));
					$('#clientdetails').val($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'clientdetails'));
					$('#agmtno').val($('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'agmtno'));
				}
				$('#fleetwindow').jqxWindow('close');
                });
        });
    </script>
    <div id="fleetSearchGrid"></div>
    