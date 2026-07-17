<%@page import="com.operations.agreement.leaseclose_alfahim.*"%>
<% String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String fleet=request.getParameter("fleet")==null?"0":request.getParameter("fleet").toString();
String regno=request.getParameter("regno")==null?"0":request.getParameter("regno").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String date=request.getParameter("date")==null?"":request.getParameter("date").toString();
String mobile=request.getParameter("mobile")==null?"0":request.getParameter("mobile").toString();
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
System.out.println("Data"+docno+regno+client+date+mobile);
ClsLeaseCloseAlFahimDAO leasedao=new ClsLeaseCloseAlFahimDAO();
%>
<script type="text/javascript">

      var radata='<%=leasedao.getAgmtno(docno,fleet,regno,client,date,mobile,branch)%>';	

        $(document).ready(function () { 	
       
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
                          	{name : 'voc_no',type:'int'},
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
     						{name : 'cldocno',type:'string'},
     						{name : 'delivery',type:'string'},
     						{name : 'acno',type:'string'},
     						{name : 'deliverychg',type:'number'},
     						{name : 'desc1',type:'String'},
     						{name : 'platecode',type:'string'}
     					
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
							{ text: 'Original Doc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Branch', datafield: 'branchname', width: '15%'},
						 	{ text: 'Fleet No', datafield: 'fleet_no', width: '10%'},
							{ text: 'Fleet Name', datafield: 'flname', width: '30%',hidden:true},
							{ text: 'Reg No', datafield: 'reg_no', width: '15%' },
							{ text: 'color', datafield: 'color', width: '30%',hidden:true },
							{ text: 'Group', datafield: 'gid', width: '30%',hidden:true },
							{ text: 'Client', datafield: 'refname', width: '20%' },
							{ text: 'Address', datafield: 'address', width: '30%',hidden:true },
							{ text: 'Mail', datafield: 'mail1', width: '30%',hidden:true },
							{ text: 'Mobile', datafield: 'per_mob', width: '20%'},
							{ text: 'Delivery', datafield: 'delivery', width: '20%',hidden:true},
							{ text: 'Description',datafield: 'desc1',width:'20%',hidden:true},
							{ text: 'Ac No', datafield: 'acno', width: '30%',hidden:true },
							{ text: 'Delivery chg', datafield: 'deliverychg', width: '30%',hidden:true },
							{ text: 'Plate Code',datafield:'platecode',width:'20%',hidden:true}
							
							]
            });
           
            $('#gridRaSearch').on('rowdoubleclick', function (event) {
            	resetvalues();
            	var rowindex1=event.args.rowindex;
             	document.getElementById("agreementno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	document.getElementById("vocno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
            	var id1=document.getElementById("agreementno").value;
            	//alert("ID"+id1);
            	//alert(id1);
            	$("#trafficdiv").load("trafficGrid.jsp?id="+document.getElementById("agreementno").value);
				$("#agmttarifdiv").load("agreementTarifGrid.jsp?agmt="+id1);
            	var temp=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
            	document.getElementById("hidfleet").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
            	temp=temp+" ,"+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "flname");
				temp=temp+" ,Reg No:"+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
				temp=temp+" ,Color:"+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "color");
				temp=temp+" ,Group:"+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "gid");
				temp=temp+" ,Plate Code:"+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "platecode");
				document.getElementById("vehicle").value=temp;
				var temp2=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "refname");
				temp2=temp2+",Address:"+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "address");
				temp2=temp2+",Mail ID:"+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "mail1");
				temp2=temp2+",Mobile:"+$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
				document.getElementById("client").value=temp2;
				var doctemp=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				var gidtemp=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "gid");
				var fleettemp=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
				var brtemp=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "branchname");
				document.getElementById("delstatus").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "delivery");
				//document.getElementById("description").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "desc1");
			document.getElementById("clientid").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
						document.getElementById("clientacno").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "acno");
								$("#referencetarifdiv").load("referenceTarifGrid.jsp?id="+id1);
						document.getElementById("deliverychg").value=$('#gridRaSearch').jqxGrid('getcellvalue', rowindex1, "deliverychg");
						
					
			$('#agmtnowindow').jqxWindow('close');

            }); 
         /*    var rows=$('#gridRaSearch').jqxGrid('getrows');
            if(rows.length==0){
            $("#gridRaSearch").jqxGrid("addrow", null, {});
            } */
        });
    </script>
    <div id="gridRaSearch"></div>
