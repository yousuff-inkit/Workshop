<%@page import="com.dashboard.client.ClsClientDAO"%>
<%ClsClientDAO DAO= new ClsClientDAO(); %>
<% String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
   String chk = request.getParameter("chk")==null?"0":request.getParameter("chk"); %>

<script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var datassss;

  if(temp4!='NA') { 
 	datassss='<%=DAO.underlitigation(barchval,chk)%>'; 
 } 
 else { 
	 datassss;
 	}  

        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
							{name : 'status', type: 'String'  },
                 			{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'},
     						{name : 'rdocno', type: 'String'}, 
     						{name : 'caseno', type: 'String'}, 
     						{name : 'station', type: 'String'},
     						{name : 'value', type: 'number'  },
     						{name : 'dtype', type: 'string'  },
     						{name : 'brhid', type: 'string'  },
     						{name : 'brhid', type: 'string'  },
     						{name : 'remarks', type: 'string'  },
     						{name : 'casenote', type: 'string'  },
     						{name : 'fdate' , type: 'date' },
     						{name : 'clstatus' , type: 'String' },
     						{name : 'voc_no' , type: 'String' },
     						{name : 'disdoc' , type: 'String' },
     						{name : 'choice' , type: 'String' }
                          	],
                          	localdata: datassss,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#undergrid").jqxGrid(
            { 
            	width: '100%',
                height: 425,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
                columns: [  
				
							{ text: 'Status', datafield: 'status', width: '6%' },
							{ text: 'Client Name', datafield: 'refname', width: '18%' },
							{ text: 'RA', datafield: 'clstatus', width: '4%' },
							{ text: 'RDOC NO', datafield: 'voc_no', width: '5%' },
							{ text: 'masterRDOC NO', datafield: 'rdocno', width: '5%',hidden:true},
							{ text: 'Case NO', datafield: 'caseno', width: '10%'},
							{ text: 'Station', datafield: 'station', width: '10%'},
							{ text: 'Remarks', datafield: 'remarks', width: '14%'},
							{ text: 'Value', datafield: 'value', width: '7%',cellsformat:'d2' ,cellsalign:'right',align:'right'},
							{ text: 'Case Note', datafield: 'casenote', width: '18%' },
							{ text: 'Follow Up Date', datafield: 'fdate', width: '8%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'DType', datafield: 'dtype', width: '10%',hidden:true },
					     	{ text: 'branchid', datafield: 'brhid', width: '10%' ,hidden:true},
							{ text: 'cldocno', datafield: 'cldocno', width: '10%' ,hidden:true},
							{ text: 'disdoc', datafield: 'disdoc', width: '10%',hidden:true },
							{ text: 'choice', datafield: 'choice', width: '10%' ,hidden:true},
					]
            });

            $("#overlay, #PleaseWait").hide();

         }); 

        $('#undergrid').on('rowdoubleclick', function (event)  { 
    	  	var rowindex1=event.args.rowindex;
    	  	document.getElementById("rentaldoc").value="";
    	  	document.getElementById("remarks").value="";
    	  	document.getElementById("branchids").value="";
    	  	document.getElementById("cldocno").value="";
    	  
    	  	$('#cmbinfo').val("");
    		$('#cmbinfo').attr("disabled",false);
    		$('#remarks').attr("readonly",false);
    		$('#driverUpdate').attr("disabled",false);
    		$('#underdate').jqxDateTimeInput({ disabled: false});
    	  
    	    document.getElementById("rentaldoc").value=$('#undergrid').jqxGrid('getcellvalue', rowindex1, "rdocno");  
    	  
    	    document.getElementById("disdoc").value=$('#undergrid').jqxGrid('getcellvalue', rowindex1, "disdoc"); 
    	    document.getElementById("choice").value=$('#undergrid').jqxGrid('getcellvalue', rowindex1, "choice"); 
    	    document.getElementById("branchids").value=$('#undergrid').jqxGrid('getcellvalue', rowindex1, "brhid");
    	 
    	    document.getElementById("cldocno").value=$('#undergrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
            $("#detaildiv").load("followDetailgrid.jsp?rdoc="+$('#undergrid').jqxGrid('getcellvalue', rowindex1, "disdoc")+"&check=1");
    	  
        });
        
</script>
<div id="undergrid"></div>