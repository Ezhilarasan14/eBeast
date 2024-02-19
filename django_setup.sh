project_name='EZSAN'
port=8760
code_type='FORMS' #SERIALIZERS, SQLALCHEMY
debug_status="TRUE"

echo "forms ${code_type}"

kill -9 $(lsof -ti:${port})
rm -rf ${project_name}
django-admin startproject ${project_name}
cd  ${project_name}

declare -a arr=("pobarls" "foo_bar" "bar_foo")

mv ../PROJ/proj_urls.py.txt  ${project_name}/urls.py
cp -r ${project_name}/urls.py ../PROJ/proj_urls.py.txt

TitleCaseConverter() {
    sed 's/.*/\L&/; s/[a-z]*/\u&/g' <<<"$1"    
}


for i in "${arr[@]}"
do
   python3 manage.py startapp ${i}
   cp -r ../APPS/app_urls.py.txt  ${i}/urls.py
   sed -i -e "s/polls/${i}/g" ${i}/urls.py
   cp -r ../APPS/app_views.py  ${i}/views.py
   sed -i -e "s/polls/${i}/g" ${i}/views.py
   # path('polls/', include('polls.urls')),
   secret="path(r\'${i}\',include(\'${i}.urls\')),\n\t#NEW_APPS="
   sed -i -e "s/#NEW_APPS=/${secret}/g" ${project_name}/urls.py
done


if [[ "$debug_status" = "FALSE" ]]; then
   echo "im in ${debug_status}"
   sed -i -e "s/DEBUG = True/DEBUG = False/g" ${project_name}/settings.py
   sed -i -e "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \[\'\*\'\]/g" ${project_name}/settings.py
fi



python3 manage.py migrate
python3 manage.py runserver ${port}
# open "http://127.0.0.1:8760/"



# Server was unable to process request. ---&gt; Data at the root level is invalid. Line 1, position 1.