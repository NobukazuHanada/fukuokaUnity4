import UnityEngine
import UnityEditor

[CustomEditor(HingeJoint2D)]		
class HingeJoint2DEditor(Editor):
	anchorPosition as Vector3
	connectedAnchorPosition as Vector3
	customTarget as  HingeJoint2D
	
	def OnEnable():
		customTarget = target
		anchorPosition = customTarget.transform.TransformPoint( customTarget.anchor )
		connectedAnchorPosition = customTarget.connectedBody.transform.TransformPoint(customTarget.connectedAnchor)
	
	def OnSceneGUI():
		if( EditorApplication.isPlaying == false):
			connectedBody = customTarget.connectedBody
			anchorPosition = Handles.PositionHandle(anchorPosition, Quaternion.identity)
			connectedAnchorPosition = Handles.PositionHandle(connectedAnchorPosition, Quaternion.identity)
			inverseAnchorPointTarget = customTarget.transform.InverseTransformPoint(anchorPosition)
			inverseAnchorPointConnected = connectedBody.transform.InverseTransformPoint(connectedAnchorPosition)
			customTarget.anchor = inverseAnchorPointTarget
			customTarget.connectedAnchor = inverseAnchorPointConnected
		if(GUI.changed):
			EditorUtility.SetDirty(target)