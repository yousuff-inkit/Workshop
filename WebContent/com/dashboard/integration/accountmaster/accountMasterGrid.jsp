<%@page import="com.dashboard.integration.accountmaster.ClsAccountMasterDAO"%>
<% ClsAccountMasterDAO DAO= new ClsAccountMasterDAO(); %>
<%   String accounttype = request.getParameter("accounttype")==null?"0":request.getParameter("accounttype").trim();
	 String branch = request.getParameter("branch")==null?"NA":request.getParameter("branch").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>

<style>     
.gpClass { background-color: #CEECF5; }
.hrClass { background-color: #F1F8E0; }
.autolineClass { background-color: #FFEBC2; }       
</style>
        
<script type="text/javascript">
      var data;
      var temp='<%=check%>';
      
	  	if(temp=='1'){ 
	  		    data='<%=DAO.accountMasterGridLoading(accounttype, branch, check)%>';   
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'account', type: 'String'  },
					{ name: 'accountname', type: 'string' },
					{ name: 'branchname', type: 'string' },
				    {name : 'gp' , type: 'string' },
				    {name : 'hr' , type: 'string' },
				    {name : 'autoline', type: 'string'  },
				    {name : 'doc_no', type: 'int'  },
				    {name : 'brhid', type: 'int'  },
				    {name : 'tobesaved', type: 'String'  }
	            ],
                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#accountMasterGridID").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: true,
                
                columns: [
						{ text: 'Account', datafield: 'account',editable: false, columngroup:'accountinfo', width: '8%' },
						{ text: 'Account Name', datafield: 'accountname',editable: false, columngroup:'accountinfo', width: '47%' },
						{ text: 'Cost Center', datafield: 'branchname',editable: false, columngroup:'accountinfo', width: '15%' },
						{ text: 'GP', datafield: 'gp', columngroup:'amount', cellclassname: 'gpClass', width: '10%' },
						{ text: 'HR', datafield: 'hr', columngroup:'amount', cellclassname: 'hrClass',  width: '10%' },
						{ text: 'Auto Line', datafield: 'autoline', columngroup:'amount', cellclassname: 'autolineClass', width: '10%' },
						{ text: 'Acno', datafield: 'doc_no',hidden: true, width: '10%' },
						{ text: 'Brhid', datafield: 'brhid',hidden: true, width: '10%' },
						{ text: 'To be Saved', datafield: 'tobesaved',hidden: true, width: '5%' },
					 ], columngroups: 
	                     [
	                       { text: 'Account Informations', align: 'center', name: 'accountinfo',width: '20%' },
	                       { text: 'Mapping Accounts', align: 'center', name: 'amount',width: '20%' },
	                     ]
            });
            
            if(temp!='1'){
                $("#accountMasterGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
            $("#accountMasterGridID").on('cellvaluechanged', function (event){
            	var acno = $('#txtaccounts').val();
            	var brhid = $('#txtaccountbrhid').val();
            	var rowindex1 = event.args.rowindex;
            	if(acno.trim()==''){
                    document.getElementById("txtaccounts").value = $('#accountMasterGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                    document.getElementById("txtaccountbrhid").value = $('#accountMasterGridID').jqxGrid('getcellvalue', rowindex1, "brhid");
            	} else {
            		document.getElementById("txtaccounts").value = acno+"::"+$('#accountMasterGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
            		document.getElementById("txtaccountbrhid").value = brhid+"::"+$('#accountMasterGridID').jqxGrid('getcellvalue', rowindex1, "brhid");
            	}      
            	$('#accountMasterGridID').jqxGrid('setcellvalue', rowindex1, "tobesaved" ,"1"); 
            	
            });
  });
                       
</script>
<div id="accountMasterGridID"></div>