<%@page import="com.dashboard.workshop.vehiclehistory.ClsVehicleHistoryDAO"%>
<%
ClsVehicleHistoryDAO DAO= new ClsVehicleHistoryDAO();
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String pltid=request.getParameter("pltid")==null?"":request.getParameter("pltid");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
%>
       
<script type="text/javascript">
var id='<%=id%>';
if(id=="1"){
		var sparedata='<%=DAO.getSparepartsData(regno,pltid,id,fromdate,todate,psrno)%>';
		<%-- var vehispartsexc='<%=DAO.getSparepartsDataexcel(regno,pltid,id,fromdate,todate)%>'; --%>
}
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                        {name : 'qty', type: 'number'  },
                        {name : 'kmin', type: 'number'  },
                        {name : 'description', type: 'string'   },
                        {name : 'jono', type: 'string'   },
                        {name : 'jdate', type: 'date'   },
                        ],
                 	localdata: sparedata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#sparegrid").jqxGrid(
            {
                width: '100%',
                height: 220,
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
						{ text: 'Job Card No..', datafield: 'jono', width: '10%' },
						{ text: 'Date', datafield: 'jdate', width: '10%',cellsformat:'dd.MM.yyyy' },
						{ text: 'KM', datafield: 'kmin', width: '10%' },
						{ text: 'Description', datafield: 'description', editable:false },		
						{ text: 'Qty', datafield: 'qty', width: '20%' },
						
						]
            });
            $("#overlay, #PleaseWait").hide();
         
        });
    </script>
    <div id="sparegrid"></div>