<%@page import="com.dashboard.analysis.leaserevenuerecognition.*"%>
<%
ClsLeaseRevenueRecognitionDAO agmtdao=new ClsLeaseRevenueRecognitionDAO();
String client = request.getParameter("client")==null?"":request.getParameter("client").trim();
String mobile = request.getParameter("mobile")==null?"":request.getParameter("mobile");
String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
String mrano = request.getParameter("mrano")==null?"":request.getParameter("mrano");
String fleetno = request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String regno = request.getParameter("regno")==null?"":request.getParameter("regno");
String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String id = request.getParameter("id")==null?"":request.getParameter("id");
%> 
 <script type="text/javascript">
 var id='<%=id%>';
var agmtdata;
if(id=="1"){
	agmtdata='<%=agmtdao.getAgmtData(client,mobile,docno,mrano,fleetno,regno,branch,id)%>'; 
}
        
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                 		
     						{name : 'refname', type: 'String'},
     						{name : 'per_mob', type: 'String'},
     						{name : 'fleet_no', type: 'String'}, 
     						{name : 'reg_no', type: 'String'},
     						{name : 'voc_no',type: 'String'},
      						{name : 'doc_no', type: 'String'  },
      					
                          	],
                          	localdata: agmtdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#agmtSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
               
                columns: [
							{ text: 'Original Doc No', datafield: 'doc_no', width: '12%',hidden:true },
							{ text: 'Doc No', datafield: 'voc_no', width: '12%' },
							{ text: 'Fleet No', datafield: 'fleet_no', width: '12%' },
							{ text: 'Name', datafield: 'refname', width: '40%' }, 
							{ text: 'Mobile', datafield: 'per_mob', width: '22%' },
							{ text: 'Reg No', datafield: 'reg_no', width: '14%'},
				
					]
            });
    

      
				            
            $('#agmtSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("agmtno").value = $('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
                document.getElementById("hidagmtno").value = $('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                var details="";
                details="Client  : "+$('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex1, "refname");
                details+="\nMobile  : "+$('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
                details+="\nVehicle : "+$('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+" - "+$('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex1, "reg_no");
            	$('#agmtdetails').val(details);
                $('#agmtwindow').jqxWindow('close'); 
            });  
				           
 }); 
</script>
<div id="agmtSearchGrid"></div>
    
