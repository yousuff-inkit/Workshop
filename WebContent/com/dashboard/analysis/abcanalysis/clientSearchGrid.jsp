<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.abcanalysis.ClsAbcAnalysis"%>
<%ClsAbcAnalysis DAO= new ClsAbcAnalysis(); %>
 <% String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
    String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
    String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
    String passno = request.getParameter("passno")==null?"0":request.getParameter("passno");
    String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
    String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
    String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");%> 

 <script type="text/javascript">
 
 var data1='<%=DAO.clientSearch(branch,clname,mob,lcno,passno,nation,dob)%>';
 
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						{name : 'acno', type: 'String'  }, 
      						{name : 'codeno', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						{name : 'contactperson', type: 'String'},
     						{name : 'mail1', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						{name : 'dob', type: 'date' },
     						{name : 'dlno', type: 'String'  }, 
      						{name : 'nation', type: 'String' },
      						{name : 'drname', type: 'String' },
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',

                columns: [
							{ text: 'Client Id', datafield: 'cldocno', width: '7%' },
							{ text: 'Name', datafield: 'refname', width: '28%' },
							{ text: 'Driver Name', datafield: 'drname', width: '14%',hidden:true },
							{ text: 'DOB', datafield: 'dob', width: '8%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Mobile', datafield: 'per_mob', width: '10%' },
							{ text: 'Tel', datafield: 'per_tel', width: '8%',hidden:true },
							{ text: 'Licence', datafield: 'dlno', width: '9%' },
							{ text: 'Nation', datafield: 'nation', width: '9%' },
							{ text: 'Address', datafield: 'address', width: '25%' }, 
							{ text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
							{ text: 'Codeno', datafield: 'codeno', width: '20%',hidden:true },
							{ text: 'SALESMAN', datafield: 'sal_name', width: '20%',hidden:true },
							{ text: 'SAL_ID', datafield: 'doc_no', width: '20%',hidden:true },
							{ text: 'Contact Person', datafield: 'contactperson', width: '20%',hidden:true },
							{ text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
					    ]
            });
				           
}); 
                       
</script>

<div id="jqxclientsearch"></div>
    
</body>
</html>