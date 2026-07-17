<%@page import="com.dashboard.workshop.partsplanning.*" %>
<%
ClsPartsPlanningDAO plandao=new ClsPartsPlanningDAO();
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
	/*var renderertotal=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	if(value!="" && value!=null && value!="undefined"){
     		 $('#total').val(value.replace(/\,/g,""));
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }*/
     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'rowno', type: 'number'  },
				{name : 'description', type: 'string'   },
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
				{name : 'goodsissueqty',type:'number'},
				{name : 'nipurchasedocno',type:'number'}
          ],
          localdata: partsdata,
         
         
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
							{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text: 'Row No', datafield: 'rowno', width: '8%',editable:true,hidden:true},
							{ text: 'Description', datafield: 'description', width: '36%',editable:true },		
							{ text: 'Qty', datafield: 'qty', width: '6%',editable:true },
							{ text: 'Rate', datafield: 'rate', width: '8%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Purchase Price', datafield: 'purchaseprice', width: '8%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},		
							{ text: 'PSR No', datafield: 'psrno', width: '8%',editable:true,hidden:true},
							{ text: 'Product Name', datafield: 'productname', width: '25%',editable:false},
							{ text: 'Brand', datafield: 'brand', width: '10%',hidden:true,editable:false},
							{ text: 'Stock', datafield: 'stock', width: '5%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Issue Qty', datafield: 'issqty', width: '6%',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
							{ text: 'Part Docno', datafield: 'partdocno', width: '10%',hidden:true,editable:false},
							{ text: 'goodsissueqty', datafield: 'goodsissueqty', width: '10%',hidden:true,editable:false},
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
            
            function valchange(rowBoundIndex)
            {
            	 var availqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'qty');
		          var issueqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'issqty');
		        
		          var stkval=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'stock');
		          
		          var prdname=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'description');
		          
		          var goodsissueqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'goodsissueqty');
		          
		          availqty=parseFloat(availqty)-parseFloat(goodsissueqty);
		         // alert("chk=="+chk);
		          if((parseFloat(stkval)==0) ){
		        	
		        	//  $.messager.alert('Message','Product - '+prdname+' - Not in Stock.');     	
		        	  $('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'issqty',"0");
		        	
		        	  }
		          
		         /*  else{
		        	  if((parseFloat(stkval)>0) ){
			           if(parseFloat(issueqty)>parseFloat(availqty)){
			        	//  alert("issqty=="+issueqty+"==availqty=="+availqty);
			        	  $('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'issqty',availqty);
			          } 
		        	  }
		          } */
		         
            }
            function valchangenw(rowBoundIndex)
            {
            	 var availqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'qty');
		          var issueqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'issqty');
		        
		          var stkval=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'stock');
		         // alert("chk=="+chk);
		          var goodsissueqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'goodsissueqty');
		         // alert("goodsissueqty=="+goodsissueqty);
		           availqty=parseFloat(availqty)-parseFloat(goodsissueqty);
		         
		        	  if((parseFloat(stkval)>0) ){
			           if(parseFloat(issueqty)>parseFloat(availqty)){
			        	//  alert("issqty=="+issueqty+"==availqty=="+availqty);
			        	  $('#partsGrid').jqxGrid('setcellvalue',rowBoundIndex,'issqty',availqty);
			          } 
		        	  }
		          
		         
            }
            $("#partsGrid").on("cellbeginedit", function (event)
        			{
        
                var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		   
				    if(datafield=="issqty"){
				    	//alert("in val");
				    	valchange(rowBoundIndex);
						         
				    }
        			});
            $("#partsGrid").on("cellvaluechanged", function (event)
        			{
        
                var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		   
				    if(datafield=="issqty"){
				    	//alert("in val");
				    	valchangenw(rowBoundIndex);
						         
				    }
        			});
          /*   $("#partsGrid").on("rowselect", function (event)
        			{
            	  var datafield = event.args.datafield;
          		
      		    var rowBoundIndex = event.args.rowindex;
      		    
      		  var issueqty=$('#partsGrid').jqxGrid('getcellvalue',rowBoundIndex,'issqty');
      		  if(parseFloat(issueqty)==0){
      			 $.messager.alert('Message','Enter Issue Qty.');
      			$('#partsGrid').jqxGrid('unselectrow',rowBoundIndex);
      		  }
        			}); */
			$("#partsGrid").jqxGrid("addrow", null, {});
        });
    </script>
    	<div id="partsGrid"></div>
    	
   <input type="hidden" name="partsindex" id="partsindex">
