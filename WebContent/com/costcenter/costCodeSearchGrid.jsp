<%@page import="com.common.ClsCostCenter"%>
<% ClsCostCenter DAO= new ClsCostCenter(); %>
<% String form = request.getParameter("formname").toString();%>
<% String dtype1 = request.getParameter("costtype").toString();


%> 


<script type="text/javascript">
  

//alert(costtype);
  	 $(document).ready(function () { 	
  		var costcode= '<%=DAO.costCodeSearch(dtype1) %>';
  		var formname='<%=form%>';
  		var costtype='<%=dtype1%>';  		
		
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'doc_no', type: 'string'  },
							{name : 'reg_no', type: 'string'  },
                            {name : 'code', type: 'string'  },
                            {name : 'jobno', type: 'string'  },
                            {name : 'project', type: 'string'  },
                            {name : 'name', type: 'string'  },
                            {name : 'customer', type: 'string'  },
                            {name : 'reftype', type: 'string'  },
							{name : 'voc_no', type: 'string'  }
                           
                        ],
                      localdata: costcode,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }                          
            };
         
		    $("#costcodeSearch").on("bindingcomplete", function (event) {
		    	$('#costcodeSearch').jqxGrid('hidecolumn', 'jobno');
		    	$('#costcodeSearch').jqxGrid('hidecolumn', 'project');
			    
		    	if (costtype !="6"){
            		$('#costcodeSearch').jqxGrid('hidecolumn', 'reg_no');
			    } 
		    	
		    	if (costtype =="7"){
            		$('#costcodeSearch').jqxGrid('showcolumn', 'jobno');
            		$('#costcodeSearch').jqxGrid('showcolumn', 'project');
			    }
		    	if (costtype =="9" ){
            		$('#costcodeSearch').jqxGrid('showcolumn', 'reg_no');
            		var hasColumn=funCheckGridColumn(formname,'costcodevocno');
                    if(hasColumn){
                    	$('#costcodeSearch').jqxGrid('showcolumn', 'voc_no');	
                    	$('#costcodeSearch').jqxGrid('hidecolumn', 'doc_no');
                    }
                    else{
                    	$('#costcodeSearch').jqxGrid('hidecolumn', 'doc_no');
                    	$('#costcodeSearch').jqxGrid('hidecolumn', 'voc_no');
                    }
            		$('#costcodeSearch').jqxGrid('showcolumn', 'customer');
            		$('#costcodeSearch').jqxGrid('hidecolumn', 'code');
			    }
		    	
		    	
		    	if (costtype =="1" ){
            		$('#costcodeSearch').jqxGrid('showcolumn', 'code');
            		$('#costcodeSearch').jqxGrid('showcolumn', 'name');
            		$('#costcodeSearch').jqxGrid('hidecolumn', 'customer');
            		$('#costcodeSearch').jqxGrid('hidecolumn', 'reftype');
            		
			    }
		    	
		    	
		    	
		    	
            });
			
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costcodeSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                columnsresize : true,
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Job Docno', datafield: 'doc_no', width: '20%', hidden: true},
							  { text: 'Reg No.', datafield: 'reg_no', width: '20%'},
							  { text: 'Customer', datafield: 'customer' },
							  { text: 'RefType', datafield: 'reftype' ,hidden:true},
                              { text: 'Cost Code', datafield: 'code', width: '20%'},
                              { text: 'Job No', datafield: 'jobno', width: '15%'},
                              { text: 'Project', datafield: 'project', width: '15%'},
                              { text: 'Cost Description', datafield: 'name',hidden:true },
							  { text: 'Job Docno', datafield: 'voc_no', width: '20%', hidden: true},
                             
                              
						]
            });
            
           $('#costcodeSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	var tempcosttype='<%=request.getParameter("costtype").toString()%>';  
            //	alert(tempcosttype);
            
  
                var rowindex2 = event.args.rowindex;
               // alert("costtype==="+costtype);
             //   alert("costtype==="+$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "code"));
                if(tempcosttype==1){
                	$('#'+formname).jqxGrid('setcellvalue', rowindex1, "costcode" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "code"));
                    var hasColumn=funCheckGridColumn(formname,'costcodevocno');
                    if(hasColumn){
                    	$('#'+formname).jqxGrid('setcellvalue', rowindex1, "costcodevocno" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "code"));	
                    }
                 }
                else if(tempcosttype==9){
                	$('#'+formname).jqxGrid('setcellvalue', rowindex1, "costcode" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                    var hasColumn=funCheckGridColumn(formname,'costcodevocno');
                    if(hasColumn){
                    	$('#'+formname).jqxGrid('setcellvalue', rowindex1, "costcodevocno" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "voc_no"));	
                    }
                }
              
                
				if(formname=="jqxFuelCardReimbursement"){
				    $('#'+formname).jqxGrid('setcellvalue', rowindex1, "reg_no" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "reg_no"));
	                var rows = $('#jqxFuelCardReimbursement').jqxGrid('getrows');
	                var rowlength= rows.length;
	                var rowindex2 = rowlength - 1;
	          	    var costtype=$("#jqxFuelCardReimbursement").jqxGrid('getcellvalue', rowindex2, "costtype");
	          	    if(typeof(costtype) != "undefined" && costtype != ""){
	          	    	$("#jqxFuelCardReimbursement").jqxGrid('addrow', null, {"costtype": "6","costgroup": "Fleet","costcode": "","amount1": "","baseamount1": "","description": ""});
	          	    }
                }
				
                $('#costCodeSearchWindow').jqxWindow('close'); 
            });  
        });
		function funCheckGridColumn(gridid,columnname){
        	var cols=$('#'+gridid).jqxGrid('columns');
        	for(var j=0;j<cols.records.length;j++){
        		var datafield=cols.records[j].datafield;
            	if(datafield==columnname){
            		return true;
            	}
            }
            
            return false;
        }
    </script>
    <div id="costcodeSearch"></div> 