import boto3
import sys

def list_instances(ec2):
    instances = ec2.instances.all()
    for instance in instances:
        print(f'ID: {instance.id}, State: {instance.state["Name"]}, Type: {instance.instance_type}')

def start_instance(ec2, instance_id):
    instance = ec2.Instance(instance_id)
    instance.start()
    print(f'Starting instance: {instance_id}')

def stop_instance(ec2, instance_id):
    instance = ec2.Instance(instance_id)
    instance.stop()
    print(f'Stopping instance: {instance_id}')

def main():
    ec2 = boto3.resource('ec2', region_name='ap-south-1')

    if len(sys.argv) < 3:
        print("Usage: manage_ec2.py <list|start|stop> <instance_id>")
        sys.exit(1)

    action = sys.argv[1]
    instance_id = sys.argv[2] if len(sys.argv) > 2 else None

    if action == 'list':
        list_instances(ec2)
    elif action == 'start' and instance_id:
        start_instance(ec2, instance_id)
    elif action == 'stop' and instance_id:
        stop_instance(ec2, instance_id)
    else:
        print("Invalid action or missing instance ID.")

if __name__ == "__main__":
    main()