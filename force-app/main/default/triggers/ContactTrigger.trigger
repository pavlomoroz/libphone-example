trigger ContactTrigger on Contact (before insert, before update) {
    ContactHandler.handleTrigger(Trigger.new, Trigger.oldMap, Trigger.operationType);
}