   <%@page import="com.dashboard.audit.accountsetup.ClsAccountCntrlRegDAO"%>
     <%ClsAccountCntrlRegDAO DAO= new ClsAccountCntrlRegDAO(); %>
 <% String contextPath=request.getContextPath();%>
 
 <%
    String barchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
  	String chk_val = request.getParameter("chk_val")==null?"0":request.getParameter("chk_val").trim();
 %> 
           	  
 <style type="text/css">
  
    .yellowClass
    {
        background-color: #F8E489;  
    }
    
    .orangeClass
    {
        background-color: #FAD7A0;
    }
  .greenClass
    {
        background-color: #7AFA90;
    }
     .whiteClass
    {
        background-color: #FFFFFF;
    }
</style>
<script type="text/javascript">

 var temp4='<%=id%>';

var accountdatas;

 if(temp4!='0' )
{ 
	 accountdatas='<%=DAO.accountContrlRegGrid(barchval,id)%>' ; 
	 var accountexcel='<%=DAO.accountContrlRegExcel(barchval,"1")%>' ; 
} 

else{
	
 accountdatas=[];
	
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                        {name : 'codeno', type: 'String'  },
                        {name : 'acno', type: 'String'  },
						{name : 'aType', type: 'date'  },
						{name : 'brhId', type: 'date'  },
						{name : 'doc_no', type: 'String'  },
						{name : 'costtype', type: 'String'  },
						{name : 'costcode', type: 'String'  },
					    {name : 'description', type: 'String'  },
					    {name : 'btnval', type: 'String'  },
					    {name : 'accountname', type: 'String'  },
					    {name : 'account', type: 'String'  },
						],
				    localdata: accountdatas,
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
    
    
    $("#acntCntrlRegId").jqxGrid(
    {
        width: '99%',
        height: 535,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
       // selectionmode: 'singlerow',
    	selectionmode: 'singlecell',
        pagermode: 'default',
        editable:false,
        columnsresize:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%', 
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    }, 
                     { text: 'Code No', datafield: 'acno',  width: '6%',hidden: true}, 
                     { text: 'Code', datafield: 'codeno',  width: '20%' }, 
           	         { text: 'Description', datafield: 'description',  width: '25%' }, 
				     { text: 'Account Type',datafield: 'aType',hidden:true},
				     { text: 'Cost Type',datafield: 'costtype',hidden: true},
				     { text: 'Document no',datafield: 'doc_no',hidden: true},
				     { text: 'Cost Code',datafield: 'costcode',hidden: true},
				     { text: 'Branch',  datafield: 'brhId',hidden:true },
				     { text: 'Account',  datafield: 'account' },
				     { text: 'Account Name',  datafield: 'accountname' },
				     { text: '',  datafield: 'btnval',columntype: 'button', width: '6%' },
					]

   
    });
    $("#overlaysub, #PleaseWaitsub").hide();
     
   $('#acntCntrlRegId').on('celldoubleclick', function (event) 
		   { 
	   
	   var rowindex1=event.args.rowindex;
	   var datafield=event.args.datafield;
	   
	   if(datafield=="account"){
		   var rowindex1=event.args.rowindex;
		   getAccount(rowindex1);
		}
	   
		   });
   $('#acntCntrlRegId').on('cellclick', function (event) 
		   { 
	   var rowindex1=event.args.rowindex;
	   var datafield=event.args.datafield;
	   if(datafield=="btnval"){
	    	var codename=$('#acntCntrlRegId').jqxGrid('getcellvalue', rowindex1, "codeno");
	    	var acno=$('#acntCntrlRegId').jqxGrid('getcellvalue', rowindex1, "acno");
			funupdate(codename,acno); 
		} 
		   });
    
});


</script>
<div id="acntCntrlRegId"></div>