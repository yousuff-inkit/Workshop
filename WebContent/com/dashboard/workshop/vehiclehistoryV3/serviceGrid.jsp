<%@page import="com.dashboard.workshop.vehiclehistoryv3.*" %>
 <%ClsVehicleHistoryV3DAO dao=new ClsVehicleHistoryV3DAO();
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String pltid=request.getParameter("pltid")==null?"":request.getParameter("pltid");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
       
<script type="text/javascript">
var id='<%=id%>';
var clientdata=[];
if(id=="1"){
		<%-- clientdata='<%=dao.getServices(regno,pltid,id,fromdate,todate)%>'; --%>
		<%-- var vehisserviceexc='<%=DAO.getServicesexcel(regno,pltid,id,fromdate,todate)%>'; --%>
}
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'jobdesc', type: 'string'},
							{name : 'jobtype',type:'string'},
							{name : 'jobno', type: 'string'   },
							{name : 'jobvocno', type: 'string'   },
			                {name : 'jdate', type: 'date'   },
			                {name : 'serviceadvisor',type:'string'},
			                {name : 'technician',type:'string'},
                
	          ],
                 	localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
	        $("#complaint").on('bindingcomplete', function (event) {
				    var configalice=$('#txtalice').val();	
				    if(parseInt(configalice)==1){
					    $('#complaint').jqxGrid('hidecolumn', 'serviceadvisor');
					    $('#complaint').jqxGrid('hidecolumn', 'technician');
				    }else{
					    $('#complaint').jqxGrid('showcolumn', 'serviceadvisor');
					    $('#complaint').jqxGrid('showcolumn', 'technician');   
				    }   		
			 });
            var dataAdapter = new $.jqx.dataAdapter(source);  
            
            $("#complaint").jqxGrid(
            {
                width: '100%',
                height: 210,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columns: [
								{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '6%', cellsrenderer: function (row, column, value) {
								    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}   },
								{ text: 'Job Card No', datafield: 'jobno', width: '8%',editable:true,hidden:true },
								{ text: 'Job Card No', datafield: 'jobvocno', width: '8%',editable:true },
	      						{ text: 'Date', datafield: 'jdate', width: '8%',cellsformat:'dd.MM.yyyy'},
                              	{ text: 'Job Type', datafield: 'jobtype', width: '30%' },
                              	{ text: 'Job Description', datafield: 'jobdesc'},
                              	{ text: 'Service Advisor',datafield:'serviceadvisor',width:'12%'},
                              	{ text: 'Technician',datafield:'technician',width:'12%'},
						]
            });
            $("#overlay, #PleaseWait").hide();
         
        });
    </script>
    <div id="complaint"></div>