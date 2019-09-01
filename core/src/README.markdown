
# Create First User

```
(create-angel :name "岩崎仁是" :creator :initial)

(let ((angel (get-angel :id 1)))
  (create-setting-auth angel
                       :email "your@email.com"
                       :password "password"
                       :editor angel))
```
