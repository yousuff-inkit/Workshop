<%@page import="com.dashboard.workshop.quotationapprovalv4.*" %>
<%ClsQuotationApprovalDAO gatedao=new ClsQuotationApprovalDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String addition=request.getParameter("addition")==null?"0":request.getParameter("addition");
%>
<script type="text/javascript">
var labourcostdata;
var id='<%=id%>';
if(id=="1"){
	labourcostdata='<%=gatedao.getLabourcostData(docno,id,addition)%>';
}
$(document).ready(function () { 
	
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="" || value==null || value=="undefined"){
     		value=0.0;
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'hrs', type: 'number'  },
				{name : 'jobdesc', type: 'string'   },
				{name : 'jobid',type:'number'},
				{name : 'jobtype',type:'string'},
				{name : 'rate',type:'number'},
				{name : 'markuppercent',type:'number'},
				{name : 'total',type:'number'},
				{name : 'remarks',type:'string'},
				{name : 'rowno',type:'number'}
          ],
          localdata: labourcostdata,
         
         
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

            
            
            $("#labourGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                disabled:false,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                pagermode: 'default',
                editable:false,
                enabletooltips:true,	
                showaggregates:true,
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
                            { text: 'Row No', datafield: 'rowno', width: '10%',hidden:true },
							{ text: 'Job Type', datafield: 'jobtype', width: '20%' },
							{ text: 'Job Desc',datafield:'jobdesc',width:'65.5%'},
							{ text: 'Job ID', datafield: 'jobid', width: '10%' ,hidden:true},
							{ text: 'Hrs', datafield: 'hrs', width: '8%' ,hidden:true},
							{ text: 'Rate', datafield: 'rate', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
							{ text: 'Markup %', datafield: 'markuppercent', width: '8%' ,hidden:true},
							{ text: 'Total', datafield: 'total', width: '8%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
							{ text: 'Remarks', datafield: 'remarks', width: '40%',hidden:true }
			              ]
            });
            
        });
    </script>
    <div id="labourGrid"></div>
	<input type="hidden" name="labourindex" id="labourindex">