<%@page import="com.dashboard.workshop.partspurchase.ClsPartsPurchaseDAO" %>
<%ClsPartsPurchaseDAO plandao=new ClsPartsPurchaseDAO();
String estdocno=request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<style type="text/css">
	.greenClass{
		background-color:#79FFA0;
	}
</style>
<script type="text/javascript">
var partsdata=[];
var id='<%=id%>';
var chk=0;
if(id=="1"){
	partsdata='<%=plandao.getPartsData(estdocno,id,brhid)%>';
}
$(document).ready(function () { 
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'rowno', type: 'number'},
				{name : 'description', type: 'string'},
				{name : 'rate', type: 'number'   },
				{name : 'qty',type:'number'},
				{name : 'psrno',type:'string'},
				{name : 'productname',type:'string'},
				{name : 'brand',type:'string'},
				{name : 'partdocno',type:'string'},
				{name : 'stock',type:'string'},
				{name : 'prdid',type:'string'},
				{name : 'unitdocno',type:'string'},
				{name : 'specid',type:'string'},
				{name : 'purchaseprice',type:'number'},
				{name : 'purchasereqdocno',type:'number'},
				{name : 'issqty',type:'number'},
				{name : 'cdqty',type:'number'},
				{name : 'nipoqty',type:'number'},
				{name : 'balqty',type:'number'},
				{name : 'niqty',type:'number'},
              	{name : 'nibalqty',type:'number'},
				{name : 'nipurchasedocno',type:'number'},
				{name : 'issuebalqty',type:'number'},
				{name : 'hidnipoqty',type:'number'},
          ],
          localdata: partsdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     
     $("#partsGrid").on("bindingcomplete", function (event) { 
      	var rows = $("#partsGrid").jqxGrid('getrows');   
         for(var i=0;i<rows.length;i++){
         	var balqty=$('#partsGrid').jqxGrid('getcellvalue', i, "balqty");  
         	var nibalqty=$('#partsGrid').jqxGrid('getcellvalue', i, "nibalqty");

         	if(parseFloat(balqty)<0){
         		$('#partsGrid').jqxGrid('setcellvalue', i, "balqty",0);
         	}
         	
         	if(parseFloat(nibalqty)<0){
         		$('#partsGrid').jqxGrid('setcellvalue', i, "nibalqty",0);
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
            
            $("#partsGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: false,
                selectionmode: 'checkbox',
                pagermode: 'default',
                editable:true,
                showaggregates:true,
                enabletooltips:true,
                showstatusbar:false,
                //Add row method
               handlekeyboardnavigation: function (event) {
                    /*var cell = $('#sparePartsNewGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'approvedvalue') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            $("#sparePartsNewGrid").jqxGrid('addrow', null, {});
                            return true;                         
                        }
                    }*/
                }, 
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '3%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            	}   
							},	
							{ text: 'Description', datafield: 'description', width: '17%',editable:true },		
							{ text: 'Qty', datafield: 'qty', width: '6%',editable:true },
							{ text: 'Rate', datafield: 'rate', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Product Name', datafield: 'productname', width: '18%',editable:false},
							{ text: 'Stock', datafield: 'stock', width: '5%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Issue Qty', datafield: 'issqty', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'CD Qty', datafield: 'cdqty', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'PO Qty', datafield: 'nipoqty', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Bal Qty', datafield: 'balqty', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',editable:false},
							{ text: 'NI Qty', datafield: 'niqty', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'NI Bal Qty', datafield: 'nibalqty', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',editable:false},
							{ text: 'Price', datafield: 'purchaseprice', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},		
						
						    { text: 'Row No', datafield: 'rowno', width: '8%',editable:true,hidden:true},
							{ text: 'PSR No', datafield: 'psrno', width: '8%',editable:true,hidden:true},
							{ text: 'Brand', datafield: 'brand', width: '10%',hidden:true,editable:false},
							{ text: 'Part Docno', datafield: 'partdocno', width: '10%',hidden:true,editable:false},
							{ text: 'PRD ID', datafield: 'prdid', width: '10%',hidden:true,editable:false},
							{ text: 'Unit Docno', datafield: 'unitdocno', width: '10%',hidden:true,editable:false},
							{ text: 'Spec ID', datafield: 'specid', width: '10%',hidden:true,editable:false},
							{ text: 'Purchase Req Doc No', datafield: 'purchasereqdocno', width: '10%',hidden:true,editable:false},
							{ text: 'NI Purchase Doc No', datafield: 'nipurchasedocno', width: '10%',hidden:true,editable:false},
			              ],
			              
            });
            
            $("#partsGrid").on("celldoubleclick", function (event)
			{
			    // event arguments.
			    var args = event.args;
			    // row's bound index.
			    var rowBoundIndex = event.args.rowindex;
			    // row's visible index.
			    var rowVisibleIndex = event.args.visibleindex;
			    // right click.
			    var rightClick = event.args.rightclick; 
			    // original event.
			    var ev = event.args.originalEvent;
			    // column index.
			    var columnIndex = event.args.columnindex;
			    // column data field.
			    var dataField = event.args.datafield;
			    // cell value
			    var value = event.args.value;
			    
			    if(dataField=="productname"){
            		$('#partsindex').val(rowBoundIndex);
          	  	  	$('#partssearchwindow').jqxWindow('open');
          			$('#partssearchwindow').jqxWindow('focus');
          			SearchContent('prodectnamesearch.jsp?partindex='+rowBoundIndex, 'partssearchwindow');
            	} 
			}); 
            
            $("#partsGrid").on("cellvaluechanged", function (event){
                var datafield = event.args.datafield;
    		    var rowBoundIndex = event.args.rowindex;
    		   
    		    var availqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'balqty');
    		    
				if(datafield=="issqty"){
					var prdname=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'description');
					var issuebalqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'issuebalqty');
		            var stkval=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'stock');
	            	var issueqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'issqty');
	            	
			        if((parseFloat(issueqty)>parseFloat(stkval))){
			        	Swal.fire({
							type: 'Warning',
							title: 'Warning',
							text: 'Product - '+prdname+' - Not in Stock.'
						});	
			        	$('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'issqty',stkval);
			        }
			        
			        if(parseFloat(issueqty)>parseFloat(issuebalqty)){
			        	$('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'issqty',issuebalqty);
			        } 
			        
				}else if(datafield=="cdqty"){
					 var cdqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'cdqty');
			         if(parseFloat(cdqty)>parseFloat(availqty)){
			        	  $('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'cdqty',availqty);
			         } 
					
				}else if(datafield=="nipoqty"){
					var nipoqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'nipoqty');
		          	if(parseFloat(nipoqty)>parseFloat(availqty)){
			        	  $('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'nipoqty',availqty);
			        } 
					
				}else if(datafield=="niqty"){
					var nibalqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'nibalqty');
			        var niqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'niqty');
				         
			        if(parseFloat(niqty)>parseFloat(nibalqty)){
			        	$('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'niqty',nibalqty);
			        } 
				}
				
        	});
        	
			$("#partsGrid").jqxGrid("addrow", null, {});
        });
    </script>

<div id="partsGrid"></div>
<input type="hidden" name="partsindex" id="partsindex">