<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.rawisebal.*"%>
 <%
 ClsRawiseBalanceDAO baldao= new ClsRawiseBalanceDAO();
 String  sclname = request.getParameter("sclname")==null?"":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"":request.getParameter("rno");
 String flno = request.getParameter("flno")==null?"":request.getParameter("flno");
 String sregno = request.getParameter("sregno")==null?"":request.getParameter("sregno");
 String smra = request.getParameter("smra")==null?"":request.getParameter("smra");
 String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
 String agmtstatus=request.getParameter("agmtstatus")==null?"":request.getParameter("agmtstatus");
 String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
 String branch_chk = request.getParameter("branch_chk")==null?"0":request.getParameter("branch_chk");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 String agmtfromdate=request.getParameter("agmtfromdate")==null?"":request.getParameter("agmtfromdate");
 String agmttodate=request.getParameter("agmttodate")==null?"":request.getParameter("agmttodate");
%> 
 <script type="text/javascript">
 var id='<%=id%>';
 var loaddata1;
 if(id=="1"){
	 loaddata1='<%=baldao.getAgmtno(sclname,smob,rno,flno,sregno,smra,branch_chk,branch,agmttype,agmtstatus,agmtfromdate,agmttodate,id)%>';
 }
 else{
	 loaddata1;
 }
 
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'refname', type: 'String'},
     						{name : 'per_mob', type: 'String'},
     						{name : 'fleet_no', type: 'String'}, 
     						{name : 'reg_no', type: 'String'},
     						{name : 'mrano ', type: 'string'}, 
      						{name : 'doc_no', type: 'String'  },
      						{name : 'cldocno', type: 'String'  },
      						{name : 'mrnumber', type: 'String'  },
      						{name : 'gid', type: 'String'  },
      						{name : 'voc_no', type: 'String'  },
      						{name : 'checks', type: 'String'  },
      						
                          	],
                          	localdata: loaddata1,

                          	pager: function (pagenum, pagesize, oldpagenum) {
                   
                			}
            };
            
            
            $("#agmtsearch").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            	
            	});        
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#agmtsearch").jqxGrid(
            {
                width: '100%',
                height: 290,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',
             
                columns: [
							{ text: 'RDOC NO', datafield: 'voc_no', width: '10%' },
							{ text: 'FLEET NO', datafield: 'fleet_no', width: '10%' },
							{ text: 'NAME', datafield: 'refname', width: '28%' }, 
							{ text: 'MOB', datafield: 'per_mob', width: '18%' },
							{ text: 'REG NO', datafield: 'reg_no', width: '15%'},
							{ text: 'MRA', datafield: 'mrnumber', width: '15%'},
							{ text: 'Cldoc', datafield: 'cldocno', width: '15%',hidden:true },
							{ text: 'Gid', datafield: 'gid', width: '15%',hidden:true },
							{ text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true }, 
							{ text: 'check', datafield: 'checks', width: '10%',hidden:true  }, 
							 
					
					]
            });
    
          /*   $("#jqxmainsearch").jqxGrid('addrow', null, {}); */
                  }); 
	
    </script>
    <div id="agmtsearch"></div>
    
