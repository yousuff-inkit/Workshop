<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>
 --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.nrmlist.*" %>
 <%
 ClsNrmListDAO nrmdao=new ClsNrmListDAO();
 String searchdate = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String fleetno = request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
 String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String color=request.getParameter("color")==null?"":request.getParameter("color");
String group=request.getParameter("group")==null?"":request.getParameter("group");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%> 
<script type="text/javascript">
var id='<%=id%>';
if(id=="1"){
	var datafleet= '<%=nrmdao.fleetSearch(branch,searchdate,fleetno,docno,regno,color,group,id)%>';
}
      
		$(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'reg_no',type:'String'},
     						{name : 'flname',type:'String'},
     						{name : 'color',type:'String'},
     						{name : 'gid',type :'String'},
     						{name : 'date',type:'date'},
     						{name :'doc_no',type:'String'}
     					
                 ],
                localdata: datafleet,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#fleetSearch").jqxGrid(
            {
                width: '100%',
                height: 290,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text:'Doc No',datafield:'doc_no',width:'16.66%'},
							{ text: 'Date', datafield: 'date', width: '16.66%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Fleet No', datafield: 'fleet_no', width: '16.66%' },
							{ text: 'Reg No', datafield: 'reg_no', width: '16.66%'},
							{ text: 'Color', datafield: 'color', width: '16.66%' },
							{ text: 'Group', datafield: 'gid', width: '16.66%'},
							{ text: 'Fleet Name', datafield: 'flname', width: '40%',hidden:true}
							]
            });
           
           $('#fleetSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	document.getElementById("fleet").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
               $('#fleetwindow').jqxWindow('close');
               
            }); 
        });
    </script>
    <div id="fleetSearch"></div>
