<%@page import="com.workshop.gateinpass.*" %>
<%ClsGateInPassDAO gatedao=new ClsGateInPassDAO();
String driverdocno=request.getParameter("driverdocno")==null?"":request.getParameter("driverdocno");
String driverlicense=request.getParameter("driverlicense")==null?"":request.getParameter("driverlicense");
String driverlicensedate=request.getParameter("driverlicensedate")==null?"":request.getParameter("driverlicensedate");
String drivername=request.getParameter("drivername")==null?"":request.getParameter("drivername");
String drivermobile=request.getParameter("drivermobile")==null?"":request.getParameter("drivermobile");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String agmtexist=request.getParameter("agmtexist")==null?"":request.getParameter("agmtexist");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
%>
<script type="text/javascript">
var driverdata;
var id='<%=id%>';
if(id=="1"){
	driverdata='<%=gatedao.getDriver(driverdocno,driverlicense,driverlicensedate,drivername,drivermobile,id,agmtexist,cldocno,agmtno)%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'doc_no', type: 'number'  },
				{name : 'name', type: 'string'   },
				{name : 'license',type:'number'},
				{name : 'licenseexpiry',type:'date'},
				{name : 'mobile',type:'string'}
          ],
          localdata: driverdata,
         
         
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


            
            
            $("#driverSearchGrid").jqxGrid(
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
                            { text:'Driver Doc No',datafield:'doc_no',width:'12%'},
							{ text:'License No', datafield: 'license', width: '12%' },			
							{ text:'License Expiry', datafield: 'licenseexpiry', width: '12%',cellsformat:'dd.MM.yyyy'},
							{text: 'Driver Name',datafield:'name',width:'41%'},
							{text: 'Mobile No',datafield:'mobile',width:'15%'}
							]
            });
            
            $("#driverSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                
				$('#driver').val($('#driverSearchGrid').jqxGrid('getcellvalue',row1,'name'));
				$('#hiddriver').val($('#driverSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
				$('#driverwindow').jqxWindow('close');
                });
        });
    </script>
    <div id="driverSearchGrid"></div>