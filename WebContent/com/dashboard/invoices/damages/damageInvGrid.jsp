<%@page import="com.dashboard.invoices.damages.ClsDamageInvDAO" %>
<% ClsDamageInvDAO cdd=new ClsDamageInvDAO(); %>

 <%
           	String branchval = request.getParameter("branchval")==null?"":request.getParameter("branchval").trim();
 %> 
           	  
<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 var temp4='<%=branchval%>';
var damagedata;
var aa;
 if(temp4!='NA')
{ 
	
	 damagedata='<%=cdd.damageInvSearch(branchval)%>'; 
	aa=0;
} 
else
{ 
	
	damagedata;
	aa=1;
	
	}  
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     	
						
                  
                     
                       
						
						{name : 'date', type: 'date'  },
					
						{name : 'type', type: 'String'  },
						
						{name : 'reftype', type: 'String'  },
						
						{name : 'refdocno', type: 'String'  },
						
						{name : 'refvoucherno', type: 'String'  },
						
						
						{name : 'rfleet', type: 'String'},
		        	
						{name : 'amount', type: 'number'  },
						{name : 'refname',type:'string'},
						{name : 'brhid', type: 'String'  },
						{name : 'doc_no', type: 'number'},
						{name : 'cldocno', type: 'number'  },
						{name : 'curid',  type:'String'},
						{name : 'acno',  type:'number'},
						{name : 'reg_no',type:'number'},
						{name : 'accfines',type:'number'}

						],
				    localdata: damagedata,
        
        
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
    
    
 
    
    $("#damageInvGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       sortable:true,
        columns: [   
					
					 { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Type', datafield: 'type', width: '8%' }, 
				     { text: 'Ref Type',datafield: 'reftype', width: '8%' },
				     { text: 'Ref Doc',datafield: 'refdocno', width: '11%',hidden:true},
				     { text: 'Ref Doc',datafield: 'refvoucherno', width: '10%'},
				     { text: 'Client',datafield:'refname',width:'27%'},
					 { text: 'Fleet', datafield: 'rfleet', width: '8%' },
					 { text: 'Reg No',datafield: 'reg_no',width:'8%'},
					 { text: 'Amount', datafield: 'amount', cellsformat:'d2',cellsalign:"right",align:"right", width: '10%'},
					 { text: 'Insur Excess', datafield: 'accfines', cellsformat:'d2',cellsalign:"right",align:"right", width: '10%'},
					 { text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true},
					 { text: 'brhid', datafield: 'brhid', width: '6%',hidden:true},
					 { text: 'curid', datafield: 'curid', width: '6%',hidden:true},
					 { text: 'Ac No', datafield: 'acno', width: '6%',hidden:true}
					
					]
   
    });

});
                     
  
</script>
<div id="damageInvGrid"></div>