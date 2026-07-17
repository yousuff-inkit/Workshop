<%@page import="com.dashboard.workshop.invehiclestatus.*"%> 
<%
ClsInVehicleStatusDAO DAO=new ClsInVehicleStatusDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String gipdocno=request.getParameter("gipdocno")==null?"":request.getParameter("gipdocno");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");

%>
<script type="text/javascript">
  
  var id='<%=id%>';
  var countdata;
  if(id=="1"){
	  countdata='<%=DAO.getCountData(id,todate,cldocno,gipdocno,regno,branch)%>';
  }
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'srno', type: 'number'  },
                            {name : 'status', type: 'string'  },
                            {name : 'count', type: 'number'}
                        ],
                 	localdata: countdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            $("#countGrid").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            }); 
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#countGrid").jqxGrid(
            {
                width: '100%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                altRows: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Sr No', datafield: 'srno', width: '20%', align:'center',cellsalign:'center'},
                              { text: 'Status', datafield: 'status', width: '60%' },
                              { text: 'Count', datafield: 'count', width: '20%'}
						]
            });
            
          $('#countGrid').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                var process=$('#countGrid').jqxGrid('getcellvalue',rowindex2,'srno');
                var id='<%=id%>';
                var branch='<%=branch%>';
                var todate='<%=todate%>';
                var cldocno='<%=cldocno%>';
                var gipdocno='<%=gipdocno%>';
                var regno='<%=regno%>';
                document.getElementById("docstatus").value=$('#countGrid').jqxGrid('getcellvalue',rowindex2,'status');
                $("#overlay, #PleaseWait").show();
                $('#detaildiv').load('detailGrid.jsp?process='+process+'&id='+id+'&branch='+branch+'&todate='+todate+'&cldocno='+cldocno+'&gipdocno='+gipdocno+'&regno='+regno);
            }); 
        });
    </script>
    <div id="countGrid"></div>