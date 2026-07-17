<%@page import="com.dashboard.workshop.partsmanagementnew.*" %>
<%  CLSpartsManagementDAO partsdao=new CLSpartsManagementDAO();
/* String id=request.getParameter("id")==null?"0":request.getParameter("id");*/
String rowsno=request.getParameter("rowno")==null?"":request.getParameter("rowno"); 
String check=request.getParameter("check")==null?"":request.getParameter("check");
System.out.println("rowsno===="+rowsno);  
%>
<style>
 .greenClass
        {
            background-color: #ACF6CB;
        }
 .yellowClass
    {
		background-color:#FDFF79;
	}
 .redClass
    {
		background-color:#FF8579;
	}
</style>                    
<script type="text/javascript">
var data3;
var stat=0;
var length=0;
var id='<%= check%>';
if(id!=0){    
	  data3='<%=partsdao. getSparePartData(rowsno,check)%>';	
}else{
	data3;
}
		     
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'description',type:'string'},
                  		{name : 'psrno',type:'number'},
                  		{name : 'rowno',type:'number'},
                  		{name : 'outqty',type:'number'},
                  		{name : 'partno',type:'number'},
                  		{name : 'partname',type:'string'},
                  		{name : 'qty',type:'number'},
                  		{name : 'total',type:'number'},
                  		{name : 'requested',type:'number'},
                  		{name : 'balance',type:'number'},
                  		{name : 'toberequested',type:'number'},
                  		{name : 'remarks',type:'string'},
                  		{name : 'specid',type:'string'},
                  		{name : 'unitdocno',type:'string'},
                  		{name : 'ordqty',type:'number'},
                  		{name : 'pivqty',type:'number'},
                  		{name : 'accno',type:'number'},
                  		{name : 'raccno',type:'number'},  
                		{name : 'ShipCountry',type:'string'}, 
                		{name : 'status',type:'string'},
                		{name : 'availability',type:'string'},
                		{name : 'contrastatus',type:'number'}
                  		],
				    localdata: data3,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     $("#jqxpartsgrid3").on("bindingcomplete", function (event) {
    	 	$("#overlay, #PleaseWait").hide();
	    	var rows=$("#jqxpartsgrid3").jqxGrid('getrows');
	    	length=rows.length;
	    	for(var i=0;i<rows.length;i++){	    		
	    		var bvalue=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'availability');
	    		var status=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'status');
	    		//alert(status);
	    		var qty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'qty');
	    		var purqty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'toberequested');
	    		if(bvalue==null || bvalue=="" || bvalue=="undefined" || typeof(bvalue)=="undefined"){
	    			
	    			$("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'availability', "PENDING");
	    		} 
	    		if(qty==null || qty=="" || qty=="undefined" || typeof(qty)=="undefined"){
	    			
	    			$("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'qty', "0");
	    		}
               if(purqty==null || purqty=="" || purqty=="undefined" || typeof(purqty)=="undefined"){
	    			
	    			$("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'toberequested', "0");
	    		}
               if(status==""){
            	   stat=stat+1;
            	   
               }
	    		
	    		 var rqst=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'outqty');	    		 
	    		 var bal=qty-rqst;
	    		 $("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'balance',bal);
	    		 $("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'toberequested',bal);
	    		//alert(stat);
	    		//alert(length);
	    		
	    	}
    	
    	});        
     var cellclassname = function (row, column, value, data) {
     	if(data.contrastatus==1){
         	return "greenClass";
         }
     	/* if(stat==length){
     		return "yellowClass";	
     	} */
     	
     };
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#jqxpartsgrid3").jqxGrid(
    {
        width: '99%',
        height: 200,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        editable:true,
        enabletooltips:true,
        selectionmode: 'singlecell',
        selectionmode: 'checkbox',
        sortable:false,
        columns: [
					
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellclassname: cellclassname,cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Parts',datafield:'description',editable:false,cellclassname: cellclassname},
       				{ text: 'Part No',datafield:'partno',editable:false,hidden:true},
       				{ text: 'Part Name', datafield:'partname',editable:false,hidden:true},
       				{ text: 'Qty',datafield:'qty',width:'10%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',cellclassname: cellclassname},
       				{ text: 'Cost Price',datafield:'total',width:'7%',cellsformat:'d2',cellsalign:'right',editable:true,cellclassname: cellclassname},
       				{ text: 'Purchased Qty',datafield:'outqty',width:'10%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',hidden:true},
       				{ text: 'Balance',datafield:'balance',width:'10%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',hidden:true}, /* ,cellsalign:'right',cellsformat:'d2' */
       				{ text: 'Contra Status',datafield: 'contrastatus', width: '57%',hidden:true,cellclassname: cellclassname,editable:false},
       				{ text: 'To Be Purchased',datafield:'toberequested',editable:true,align:'right',cellsalign:'right',cellsformat:'d2',hidden:true},
       				{ text: 'Pur Order Qty',datafield:'ordqty',align:'right',cellsalign:'right',cellsformat:'d2',hidden:true},
       				{ text: 'Pur Inv Qty',datafield:'pivqty',align:'right',cellsalign:'right',cellsformat:'d2',hidden:true},
       				{ text: 'Rowno',datafield:'rowno',editable:false,hidden:true},
       				{ text: 'mspecno',datafield:'specid',hidden:true},
       				{ text: 'unitdocno',datafield:'unitdocno',hidden:true},
       				{ text: 'psrno',datafield:'psrno',hidden:true},
       				{ text: 'accno',datafield:'accno',hidden:true},
       				{ text: 'raccno',datafield:'raccno',hidden:true},
       				{ text: 'Status',  datafield: 'status',width:'6%',columntype:'dropdownlist',cellclassname: cellclassname,
						
						createeditor: function (row, column, editor) {  
							
                           billmodelist1 = ["CASH","CREDIT","REPAIR","IN STORE","NONE"];
                         
							editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist1 });
						
						},
				 	 initeditor: function (row, cellvalue, editor) {     
                          
						var terms = $('#jqxpartsgrid3').jqxGrid('getcellvalue', row, "status");
						
							editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist1 });
						
                        }, 
		    
		},
		
		{ text: 'Availability',  datafield: 'availability',width:'6%',columntype:'dropdownlist',cellclassname: cellclassname,
			
			createeditor: function (row, column, editor) {
				
				 billmodelist = ["PENDING","AVAILABLE"];
				
				editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
			
			},
	 	 initeditor: function (row, cellvalue, editor) {
              
			var terms = $('#jqxpartsgrid3').jqxGrid('getcellvalue', row, "avail");
			
				editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
			
            }, 

       },
       { text: 'Remarks',datafield:'remarks',editable:true,cellclassname: cellclassname},
					]
    });
    $('#jqxpartsgrid3').on('rowselect', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    var contrastatus=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowBoundIndex, "contrastatus");
    		    if(contrastatus==1){
    		    	$('#jqxpartsgrid3').jqxGrid('unselectrow', rowBoundIndex);
    		    }
    		    var rowsCount = $('#jqxpartsgrid3').jqxGrid('getrows').length;
    		    if (event.args.rowindex.length === rowsCount) {
    		    	for(var i=0;i<rowsCount;i++){
    		    		var contrastatus=parseInt($('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'contrastatus'));
    		    		if(contrastatus>0){
    				    	$('#jqxpartsgrid3').jqxGrid('clearselection');
    				    }
    		    	}
    		    }
    		});
    $('#jqxpartsgrid3').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  		var rowindex1=event.args.rowindex;
  	  	   
  	  		/* $('#part').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"description"));
   	  	    $('#qnty').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"qty"));
   		    $('#price').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"total"));
   		    $('#rownum').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"rowno"));
   		    $('#purqty').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"requested"));
   		    $('#tbpur').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"toberequested")); */
      		});
    
    $("#jqxpartsgrid3").on("celldoubleclick", function (event) {
        var rowindex=event.args.rowindex;
        var dataField = event.args.datafield;
    	/* if(dataField=="partno"){
    		$('#partindex').val(rowindex);
    		$('#sparePartWindow').jqxWindow('open');
  			$('#sparePartWindow').jqxWindow('focus');
  			SearchContent('partNoSearch.jsp', 'sparePartWindow');
    	} */
    });
    
    $("#jqxpartsgrid3").on("cellvaluechanged", function (event) {
        var rowindex=event.args.rowindex;
        var dataField = event.args.datafield;
    	/*  if(dataField=="qty"){ 
    		 var rqst=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'requested');
    		 var qty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'qty');
    		 var bal=qty-rqst;
    		 $("#jqxpartsgrid3").jqxGrid('setcellvalue',rowindex,'balance',bal);
    	}  */
    	 
    	 if(dataField=="toberequested"){ 
    		 var qnty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'qty');
    		 var purchqty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'toberequested');
    		 var bln=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'balance');
    		 if(bln==0){
    			 $.messager.alert('Warning','Not enough balance available');
    			 $('#jqxpartsgrid3').jqxGrid('setcellvalue',rowindex,'toberequested',"0");
    		 }
    		 /* $("#jqxpartsgrid3").jqxGrid('cellsformat',rowindex,'toberequested','d2'); */
    		/*  if(tbrqst>blnc){
    			 $.messager.alert('Warning','value should be less than balance');
    			 $("#jqxpartsgrid3").jqxGrid('setcellvalue',rowindex,'toberequested',"");	 
    		 } */
    		 //var bal=qnty-purchqty; 
    		 //$("#jqxpartsgrid3").jqxGrid('setcellvalue',rowindex,'balance',bal);
    		// $("#jqxpartsgrid3").jqxGrid('setcellvalue',rowindex,'requested',purchqty);
    		 
    	} 
    });    
      
});	

	
</script>
<div id="jqxpartsgrid3"></div>
<input type="hidden" name="partindex" id="partindex">