<%@page import="com.dashboard.workshop.quotationapprovalv4.*" %>
<%ClsQuotationApprovalDAO gatedao=new ClsQuotationApprovalDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String addition=request.getParameter("addition")==null?"0":request.getParameter("addition");
%>
<script type="text/javascript">
var sparepartsdata;
var id='<%=id%>';
if(id=="1"){
	sparepartsdata='<%=gatedao.getSparepartsData(docno,id,addition)%>';
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
				{name : 'qty', type: 'number'  },
				{name : 'description', type: 'string'   },
				{name : 'partdocno', type: 'string'   },
				{name : 'rate',type:'number'},
				{name : 'markuppercent',type:'number'},
				{name : 'total',type:'number'},
				{name : 'remarks',type:'string'},
				{name : 'brand',type:'string'},
				{name : 'brdid',type:'number'},
				{name : 'stock',type:'number'},
				{name : 'rowno',type:'number'},
          ],
          localdata: sparepartsdata,
         
         
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

            
            
            $("#spareGrid").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                disabled:false,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                enabletooltips: true,
                editable:false,
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
							{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '8%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text: 'Row No', datafield: 'rowno', width: '26%',editable:false,hidden:true },
							{ text: 'Description', datafield: 'description', width: '75%',editable:false },		
							{ text: 'Part Doc No', datafield: 'partdocno', width: '26%',editable:false,hidden:true },		
							{ text: 'Brand', datafield: 'brand', width: '12%',editable:false,hidden:true },
							{ text: 'Brand Id',datafield:'brdid',width:'10%',hidden:true},
							{ text: 'Qty', datafield: 'qty', width: '10%',editable:true },
							{ text: 'Stock', datafield: 'stock', width: '6%',editable:false ,hidden:true},
							{ text: 'Rate', datafield: 'rate', width: '6%' ,cellsformat:'d2',editable:false,cellsalign:'right',align:'right',hidden:true},
							{ text: 'Markup %', datafield: 'markuppercent', width: '6%',editable:true,hidden:true },
							{ text: 'Total', datafield: 'total', width: '6%' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
							{ text: 'Remarks', datafield: 'remarks', width: '50%',editable:true,hidden:true }
			              ]
            });
            
        });
    </script>
    <div id="spareGrid"></div>
   <input type="hidden" name="partsindex" id="partsindex">
