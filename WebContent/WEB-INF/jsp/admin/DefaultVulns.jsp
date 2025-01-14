<%@page import="org.apache.struts2.components.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="bs" uri="/WEB-INF/BootStrapHandler.tld"%>
<jsp:include page="../header.jsp" />
<style>
.jconfirm-content input {
	background: #030D1C;
}
</style>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			<i class="fa fa-bug"></i> Default Vulnerabilities and Ratings <small></small>
		</h1>
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<bs:mco colsize="6">
				<bs:row>
					<jsp:include page="AddCat.jsp" />
				</bs:row>
				<bs:row>
					<bs:mco colsize="12">
						<bs:box type="warning"
							title="Vulnerability Tracking Times <span style=font-size:x-small>Number of calendar days each item is due.</span>">

							<s:iterator value="levels">
								<bs:row>
									<bs:inputgroup name="Level ${riskId } Due Date:" colsize="6"
										id="due_${riskId}">${daysTillDue }</bs:inputgroup>
									<bs:inputgroup name="Level ${riskId } Warning Date:"
										colsize="6" id="warn_${riskId}">${daysTillWarning}</bs:inputgroup>
								</bs:row>
							</s:iterator>

							<br>
							<bs:row>
							</bs:row>
							<bs:row>
								<bs:mco colsize="6"></bs:mco>
								<bs:button color="primary" size="md" colsize="6" text="Update"
									id="saveDates"></bs:button>
							</bs:row>

						</bs:box>
					</bs:mco>
				</bs:row>
				<s:if test="tier != 'consultant'">
					<bs:row>
						<s:include value="VerificationSettings.jsp"></s:include>
					</bs:row>
				</s:if>
			</bs:mco>
			<bs:mco colsize="6">
				<bs:row>
					<jsp:include page="AddVuln.jsp" />
					<!-- End row -->
				</bs:row>
				<bs:row>
					<bs:mco colsize="3">
						<button class="btn btn-danger" id="importDB">Import from Faction</button>

					</bs:mco>
					<bs:mco colsize="3">
						<a href="https://github.com/factionsecurity/data/tree/master/db">
							View VulnDB on GitHub</a>
					</bs:mco>
					<bs:mco colsize="3">
						<a class="btn btn-success"
							href="https://docs.factionsecurity.com/Importing%20Your%20Vulnerability%20Templates%20Via%20the%20API/">
							Import Your Own Via API</a>
					</bs:mco>
				</bs:row>
				<bs:row>
				</bs:row>
				<bs:row>
				<br/>
				</bs:row>
				<bs:row>
					<bs:mco colsize="12">
						<button class="btn btn-danger" id="downloadVulns">Download
							all Vulnerabilities to CSV</button>

					</bs:mco>
				</bs:row>
				<br />
				<bs:row>
					<bs:mco colsize="12">
						<bs:box type="info" title="Risk Level Settings">
							<s:iterator value="levels">
								<bs:row>
									<bs:mco colsize="2">
										<label class="pull-right">Level ${riskId
															}:</label>
									</bs:mco>
									<bs:mco colsize="7">
										<input id="riskName${riskId }" class="form-control pull-right"
											type="text" placeholder="Risk Name (ex. Critical)"
											value="${risk}"></input>
									</bs:mco>
									<bs:button color="info" size="md" colsize="3" text="Update"
										id="updateRisk${riskId}">
									</bs:button>
								</bs:row>
								<br>
							</s:iterator>

						</bs:box>
					</bs:mco>
				</bs:row>
			</bs:mco>
		</div>



		<jsp:include page="../msgModal.jsp" />

		<jsp:include page="../footer.jsp" />
		<script>
							let vulnTypes = []
								<s:iterator value = "vulntypes" status="stat">
									vulnTypes.push(${ id });
	</s:iterator >

								function getValueFromId(id) {
									switch (id) {
		  	<s:iterator value="levels">
										case "${riskId}": return "${risk}";
									</s:iterator>
		  	default : return "Unassigned";
								}
							return -1;
	  }
							function getIdFromValue(value) {
								switch (value) {
		  	<s:iterator value="levels">
									case "${risk}": return ${riskId};
								</s:iterator>
		  	default : return "-1";
							}
							return -1;
	  }
						</script>
		<script src="../dist/js/default_vulns.js"></script>

		</body>

		</html>