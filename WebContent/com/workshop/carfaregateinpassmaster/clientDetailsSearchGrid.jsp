<%@ page import="com.workshop.carfaregateinpassmaster.*" %>
<% ClsCarfareGateInPassDAO cdl=new ClsCarfareGateInPassDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String mobile = request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String email = request.getParameter("email")==null?"0":request.getParameter("email");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");%>
<script type="text/javascript">
        
       var data1= '<%=cdl.clientDetailsSearch(clientname, docno,check,id,email,mobile)%>'; 
       var id='<%=id%>';
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'   },
     						{name : 'refname', type: 'string'  },
     						{name : 'contactperson', type: 'String'},
     						{name : 'mail1', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						 {name : 'address', type: 'String'  }, 
      						{name : 'per_mob', type: 'String'  },
      						{name : 'regno', type: 'number'   },
     						
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxClientSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'cldocno', width: '10%' },
							{ text: 'Client Name', datafield: 'refname', width: '50%' },
							{ text: 'Mobile', datafield: 'per_mob', width: '20%',hidden:false},
							{ text: 'TEL', datafield: 'per_tel', width: '8%',hidden:true },
							{ text: 'ADDRESS', datafield: 'address', width: '21%',hidden:true }, 
							{ text: 'Email', datafield: 'mail1', width: '20%',hidden:false},
							{ text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
							{ text: 'regno', datafield: 'regno', width: '20%',hidden:true },
						]
            });
            
              $('#jqxClientSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                var id='<%=id%>';
                
                if(id==1){
                document.getElementById("cldocno").value = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
            	document.getElementById("clientname").value = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
            	 var temp="";
           	  temp=temp+" CONTACT PERSON : "+$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "contactperson");
               temp=temp+","+" MOB : "+$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
               temp=temp+","+" EMAIL : "+$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "mail1");
               temp=temp+","+" ADDRESS : "+$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "address");
               temp=temp+","+" TEL NO : "+$('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "per_tel");
              
               
               
           	document.getElementById("clientdetails").value=temp;
            /*var regno = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "regno");
            if(regno==""){
            	$('#vehregno').attr('placeholder','Enter Register Number');
            }
            else{
         	   $('#vehregno').attr('placeholder','Press F3 to Search');
            }*/
                }
                 else{
                	document.getElementById("clientid").value = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                	document.getElementById("insucompany").value = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
                    
                } 
            	/* var rows = $('#addDriverGridID').jqxGrid('getrows');
            	var rowlength= rows.length;
            	var rowindex2 = rowlength - 1;
          	    var name=$("#addDriverGridID").jqxGrid('getcellvalue', rowindex2, "name");
          	    if(typeof(name) != "undefined" && name != ""){
          	    	$("#addDriverGridID").jqxGrid('addrow', null, {});
          	    } */
          	    
            	$('#clientwindow').jqxWindow('close'); 
            });   
        });
    </script>
    <div id="jqxClientSearch"></div>
 