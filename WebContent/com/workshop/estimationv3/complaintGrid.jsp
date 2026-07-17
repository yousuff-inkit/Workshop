<%@page import="com.workshop.wsestimation.*" %>
<%
	ClsWSEstimationDAO estimatedao=new ClsWSEstimationDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var complaintdata;
var id='<%=id%>';
if(id=="1"){
	complaintdata='<%=estimatedao.getComplaints(docno,id)%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'complaint', type: 'string'  },
				{name : 'description', type: 'string'   },
				{name : 'complaintdocno',type:'number'}
          ],
          localdata: complaintdata,
         
         
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

            
            
            $("#complaintGrid").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                disabled:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
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
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text:'Complaint',datafield:'complaint',width:'40%',editable:false},
							{ text: 'Description', datafield: 'description', width: '55%' },			
							{ text: 'Complaint Doc No', datafield: 'complaintdocno', width: '70%',hidden:true }					
			              ]
            });
            
            $("#complaintGrid").on("celldoubleclick", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
                if(dataField=="complaint"){
                    $('#complaintwindow').jqxWindow('open');
              		$('#complaintwindow').jqxWindow('focus');
              		SearchContent('complaintGridSearch.jsp?gridrowindex='+rowindex,'complaintwindow');                	
                }

          		
				/* document.getElementById("complaintrow").value=row1;              
                	$('#complaintwindow').jqxWindow('open');
              		$('#complaintwindow').jqxWindow('focus');
               	  complaintSearchContent('complaintGridSearch.jsp'); */
              
                });
            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#complaintGrid").jqxGrid("addrow", null, {});	
            }
            

        });
    </script>
    <div id="complaintGrid"></div>
    <input type="hidden" name="complaintrow" id="complaintrow">
