import * as admin from "firebase-admin";

const db = () => admin.firestore();

export async function writeAuditLog(params: {
  actorUid: string;
  action: string;
  targetType: string;
  targetId: string;
  targetUserName?: string;
  metadata?: Record<string, unknown>;
}): Promise<void> {
  await db().collection("audit_logs").add({
    action: params.action,
    target_type: params.targetType,
    target_id: params.targetId,
    target_user_name: params.targetUserName ?? params.targetId,
    actor_uid: params.actorUid,
    metadata: params.metadata ?? {},
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  });
}
