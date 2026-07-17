<%@ page import="com.operations.agreement.rentalclose.ClsRentalCloseDAO" %>
<%ClsRentalCloseDAO crcd=new ClsRentalCloseDAO(); %>



<% String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String fleet=request.getParameter("fleet")==null?"0":request.getParameter("fleet").toString();
String regno=request.getParameter("regno")==null?"0":request.getParameter("regno").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String date=request.getParameter("date")==null?"":request.getParameter("date").toString();
String mobile=request.getParameter("mobile")==null?"0":request.getParameter("mobile").toString();
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
System.out.println("Data"+docno+regno+client+date+mobile);
%>
<script type="text/javascript">

      var radata='<%=crcd.getAgmtno(docno,fleet,regno,client,date,mobile,branch)%>';	
		
        $(document).ready(function () { 	
       
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
                          	{name : 'voc_no' , type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'branchname', type: 'String'},
     						{name : 'flname',type:'String'},
     						{name : 'fleet_no',type: 'String'},
     						{name : 'reg_no',type: 'String'},
     						{name : 'color', type: 'String'},
     						{name : 'gid',type: 'String'},
     						{name : 'address', type:'String'},
     						{name : 'mail1',type:'String'},
     						{name : 'per_mob',type: 'String'},
     						{name : 'refname',type:'String'},
     						
     						{name :'cldocno',type:'string'},
     						
     						
     					
                 ],
                localdata: radata,
                //url: url,
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
            $("#gridRaSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Voc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Branch', datafield: 'branchname', width: '15%' },
						 	{ text: 'Fleet No', datafield: 'fleet_no', width: '10%'},
							{ text: 'Fleet Name', datafield: 'flname', width: '30%',hidden:true},
							{ text: 'Reg No', datafield: 'reg_no', width: '15%' },
							{ text: 'color', datafield: 'color', width: '30%',hidden:true },
							{ text: 'Group', datafield: 'gid', width: '30%',hidden:true },
							{ text: 'Client', datafield: 'refname', width: '40%' },
							{ text: 'cldocno',datafield:'cldocno',width:'20%',hidden:true}
							]
            });
           
            $('#gridRaSearch').on('rowdoubleclick', function (event) {
            	
            	var rowindex1=event.args.rowindex;
             	document.getElementById("agmtno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	document.getElementById("agmtvocno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
             	document.getElementById("cldocno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
             	document.getElementById("fleet_no").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
             	document.getElementById("fleetdetails").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "flname")+" "+"Reg No: "+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
			$('#agmtnowindow').jqxWindow('close');

            }); 
            var rows=$('#gridRaSearch').jqxGrid('getrows');
            if(rows.length==0){
            $("#gridRaSearch").jqxGrid("addrow", null, {});
            }
        });
    </script>
    <div id="gridRaSearch"></div>
