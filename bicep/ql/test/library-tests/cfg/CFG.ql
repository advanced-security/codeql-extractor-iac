import bicep
import codeql.bicep.controlflow.ControlFlowGraph
import TestUtils

class MyRelevantNode extends CfgNode {
  MyRelevantNode() { toBeTested(this.getScope()) }
}

import codeql.bicep.controlflow.internal.ControlFlowGraphImpl::TestOutput<MyRelevantNode>
