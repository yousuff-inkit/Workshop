<%@page import="com.workshop.estimationv5.*" %>
<%
ClsEstimationV5DAO estimatedao=new ClsEstimationV5DAO();
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var packagedata=[];
var id='<%=id%>';
if(id=="1"){
	packagedata='<%=estimatedao.getPackage(gatedocno,date,id)%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'doc_no', type: 'number'  },
				{name : 'packagename', type: 'string'   },
				{name : 'fromdate',type:'date'},
				{name : 'todate',type:'date'},
				{name : 'amount',type:'number'},
				{name : 'maxusage',type:'number'},
				{name : 'contractdocno',type:'number'},
				
          ],
          localdata: packagedata,
         
         
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

            
            
            $("#packageSearchGrid").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                pagermode: 'default',
                editable:false,
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
                            { text:'Doc No',datafield:'doc_no',width:'10%'},
							{ text: 'Package Name', datafield: 'packagename', width: '45%' },
							{ text: 'From Date', datafield: 'fromdate', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'To Date', datafield: 'todate', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Amount', datafield: 'amount', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2' },
							{ text: 'Allowed', datafield: 'maxusage', width: '10%',align:'right',cellsalign:'right',cellsformat:'d0' },	
							{ text: 'Package Contract Doc No', datafield: 'contractdocno', width: '10%',align:'right',cellsalign:'right',cellsformat:'d0',hidden:true },					
			              ]
            });
            
            $("#packageSearchGrid").on("celldoubleclick", function (event) {
                var rowindex=event.args.rowindex;
                var dataField = event.args.datafield;
				var maxusage=$('#packageSearchGrid').jqxGrid('getcellvalue',rowindex,'maxusage');
				if(parseInt(maxusage)<=0){
					$.messager.alert('Warning','Max. Usage Exceeded','Warning');
					return false;
				}
				else{
					$('#packagename').val($('#packageSearchGrid').jqxGrid('getcellvalue',rowindex,'packagename'));
					$('#packagedocno').val($('#packageSearchGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
					var packagedocno=$('#packagedocno').val();
					var contractdocno=$('#packageSearchGrid').jqxGrid('getcellvalue',rowindex,'contractdocno');
					$('#labourcostdiv').load('labourcostGrid.jsp?id=2&docno='+packagedocno+'&contractdocno='+contractdocno);
					$('#sparepartsdiv').load('sparePartsNewGrid.jsp?id=2&docno='+packagedocno+'&contractdocno='+contractdocno);
					document.getElementById("chkrandomlumsum").checked=true;
					setRandomLumSum();
					//$('#randomlumsumamt').val($('#packageSearchGrid').jqxGrid('getcellvalue',rowindex,'amount'));
					$('#pkgcontractdocno').val($('#packageSearchGrid').jqxGrid('getcellvalue',rowindex,'contractdocno'));
					$('#packagesearchwindow').jqxWindow('close');
				}
        	});
        });
    </script>
    <div id="packageSearchGrid"></div>
    <input type="hidden" name="packagerow" id="packagerow">
