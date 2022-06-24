<pre>
$ kubectl apply -f deployment.yml
deployment.apps/password-api created

$ kubectl get deployment password-api
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
password-api   3/3     3            3           13m

$ kubectl get replicaset --selector=app=password-api
NAME                      DESIRED   CURRENT   READY   AGE
password-api-6b7f67dbd6   3         3         3       7m6s

$ kubectl get pods --selector=app=password-api
NAME                            READY   STATUS    RESTARTS   AGE
<b>password-api-6b7f67dbd6-f9wgv</b>   1/1     Running   0          6m46s
password-api-6b7f67dbd6-fpvs4   1/1     Running   0          6m46s
password-api-6b7f67dbd6-m4sg7   1/1     Running   0          6m46s

$ kubectl exec -it <b>password-api-6b7f67dbd6-f9wgv</b> --  bash
root@password-api-6b7f67dbd6-f9wgv:/usr/src/app# curl localhost:3000/password
{"password":"!355LlSsMmFf"}
</pre>
