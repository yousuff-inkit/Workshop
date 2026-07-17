 <%@page import="com.limousine.limotarifmgmt.*"%>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
ClsLimoTarifDAO tarifdao=new ClsLimoTarifDAO();
 %>
 
 <script>
 var datagroup1;
 <%-- if(document.getElementById("docno").value==''){
		datagroup1='<%=tarifdao.getNewGroup()%>';
	}
	else{
		datagroup1='<%=tarifdao.getGroup1(docno)%>';
	} --%>
	
var id='<%=id%>';
if(id=="1"){
	datagroup1='<%=tarifdao.getGroup1(docno)%>';
}
else{
	datagroup1='<%=tarifdao.getNewGroup()%>';
}
 $(document).ready(function () { 


	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'gid' , type: 'string' },
                          	{name :'doc_no',type:'number'}
     						],
     			localdata: datagroup1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                 //   alert(error);    
	                    }
		            });
            
            $("#gridGroup1").jqxGrid(
            {
                width: '100%',
                height: 460,
                source: dataAdapter,
                selectionmode: 'single',
               
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#gridGroup1').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'group' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#gridGroup1").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
               
                columns: [
                       
							{ text: 'Group', datafield: 'gid', width: '100%' },
							{text:'Doc',datafield:'doc_no',width:'100%',hidden:true}
	              ]
            });
            
         
         //Row Double Click
         $('#gridGroup1').on('rowdoubleclick', function (event) 
              {
          	var row2=event.args.rowindex;
          	document.getElementById("lblgroupdetails").innerText="Tariff of Group "+$('#gridGroup1').jqxGrid('getcellvalue',row2,'gid');
          	document.getElementById("hidgroup").value=$('#gridGroup1').jqxGrid('getcellvalue',row2,'doc_no');
          	$('#gridTarifTransfer').jqxGrid('clear');
			$('#gridTarifHour').jqxGrid('clear');
          	}); 
   
	});

</script>
<div id="gridGroup1"></div>