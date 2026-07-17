<%@page import="com.workshop.gateinpassmaster.ClsGateInPassDAO" %>
<%ClsGateInPassDAO gatedao=new ClsGateInPassDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var repairdata=[];
var id='<%=id%>';
if(id=="1" || id=="2"){
	 repairdata='<%=gatedao.getRepairType(docno,branch,id)%>';
	var dd='<%=branch%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'docno', type: 'string'  },
				{name : 'name', type: 'string'   },
				{name : 'grepdocno',type:'number'}
          ],
          localdata: repairdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     $("#repairTypeGrid").on("bindingcomplete", function (event) {
     	// your code here.
     	var rows=$('#repairTypeGrid').jqxGrid('getrows');
     	for(i=0;i<rows.length;i++){
     		var grepdocno=$('#repairTypeGrid').jqxGrid('getcellvalue',i,'grepdocno');
     		if(grepdocno!="" && grepdocno!=null && grepdocno!="undefined" && grepdocno!="0"){
     			$('#repairTypeGrid').jqxGrid('selectrow',i);
     		}
     	}
     });  
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
              alert(error);    
              }
        
       }		
     );

            
            
            $("#repairTypeGrid").jqxGrid(
            {
                width: '99%',
                height: 315,
                source: dataAdapter,
                columnsresize: true,
                disabled:false,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
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
                            { text:'Doc No',datafield:'docno',width:'40%',editable:false,hidden:true},
							{ text: 'Name', datafield: 'name', width: '95%' },			
							{ text: 'Grep Doc No', datafield: 'grepdocno', width: '70%',hidden:true }					
			              ]
            });

            if($('#mode').val()=='A' || $('#mode').val()=='E'){
            	$("#repairTypeGrid").jqxGrid({disabled:false});	
            }
            else{
            	$("#repairTypeGrid").jqxGrid({disabled:true});		
            }
            

        });
    </script>
    <div id="repairTypeGrid"></div>
