from django.http import HttpResponse
# from . import pollsSerializer

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")

# def create_polls(self, request, *args, **kwargs):
#     try:
#         serializer = pollsSerializer(data=request.data)
#         serializer.is_valid(raise_exception=True)
#         serializer.save()
#         return Response(serializer.data)
#     except Exception as e:
#         print('Error ->',e)
#         return Response({'status':'ERROR'})

# def update_polls(self, request, *args, **kwargs):
#     try:
#         instance = self.get_object()
#         serializer = pollsSerializer(instance=instance, data=request.data)
#         serializer.is_valid(raise_exception=True)
#         serializer.save()
#         return Response(serializer.data)
#     except Exception as e:
#             print('Error ->',e)
#             return Response({'status':'ERROR'})
