defmodule ContentfulToNeo4jEx.Transform.Test do
  import ContentfulToNeo4jEx.Transform

  use ExUnit.Case

  def assets do
    [
      %{
        "fields" => %{
          "file" => %{
            "contentType" => "image/png",
            "details" => %{
              "image" => %{"height" => 887, "width" => 1908},
              "size" => 100_983
            },
            "fileName" => "EngineeringHistory.png",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/6nvWJT1AkM64so8Auue4QQ/3b21f3ce6654e2cbe42be91d9077d274/EngineeringHistory.png"
          },
          "title" => "Contentful hero"
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:19.130Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "6nvWJT1AkM64so8Auue4QQ",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:19.130Z"
        }
      },
      %{
        "fields" => %{
          "file" => %{
            "contentType" => "image/jpeg",
            "details" => %{
              "image" => %{"height" => 999, "width" => 1500},
              "size" => 277_268
            },
            "fileName" => "contentful-team-example.jpeg",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/4dgP2U7BeMuk0icguS4qGw/f6274bf759ee2bc07020e79bb91a49ab/contentful-team-example.jpeg"
          },
          "title" => "contentful-team"
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:19.132Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "4dgP2U7BeMuk0icguS4qGw",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:19.132Z"
        }
      },
      %{
        "fields" => %{
          "file" => %{
            "contentType" => "image/svg+xml",
            "details" => %{
              "image" => %{"height" => 347, "width" => 765},
              "size" => 288_828
            },
            "fileName" => "contentful-four-apis.svg",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/1YK5kwroV6UEGS64mQs0Eo/8130fd945210890a786f1e7fb303f1e2/contentful-four-apis.svg"
          },
          "title" => "Diagram: Api first"
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:19.153Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "1YK5kwroV6UEGS64mQs0Eo",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:19.153Z"
        }
      },
      %{
        "fields" => %{
          "file" => %{
            "contentType" => "image/svg+xml",
            "details" => %{
              "image" => %{"height" => 215, "width" => 333},
              "size" => 38_421
            },
            "fileName" => "content-model-lesson.svg",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/1nXjR47jxOagUcc8iU6wUQ/35d26bd05029d3ea905f86cf5701a24b/content-model-lesson.svg"
          },
          "title" => "Diagram: Content model of a lesson"
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:19.222Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "1nXjR47jxOagUcc8iU6wUQ",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:19.222Z"
        }
      },
      %{
        "fields" => %{
          "file" => %{
            "contentType" => "image/svg+xml",
            "details" => %{
              "image" => %{"height" => 567, "width" => 312},
              "size" => 70_800
            },
            "fileName" => "content-model-full.svg",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/5o1Zu7UJheEGGQUC6gYEmS/2245339ea6df785d7d81fc9a635427a5/content-model-full.svg"
          },
          "title" => "Diagram: Content model of \"The example app\""
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:19.230Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "5o1Zu7UJheEGGQUC6gYEmS",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:19.230Z"
        }
      },
      %{
        "fields" => %{
          "file" => %{
            "contentType" => "image/svg+xml",
            "details" => %{
              "image" => %{"height" => 232, "width" => 708},
              "size" => 75_824
            },
            "fileName" => "webapp-contentful-example-app.svg",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/3z7ErmBLIccwQkQkuEY0w4/aa5c059d8f293878ae0a7e859c4e28b7/webapp-contentful-example-app.svg"
          },
          "title" => "Diagram: example app, contentful, Contentful web app"
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:19.468Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "3z7ErmBLIccwQkQkuEY0w4",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:19.468Z"
        }
      },
      %{
        "fields" => %{
          "file" => %{
            "contentType" => "image/png",
            "details" => %{
              "image" => %{"height" => 1290, "width" => 2038},
              "size" => 325_881
            },
            "fileName" => "webapp.png",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/4CWJDjGTzaU8CMAW2eYeie/0446fca0a17e7db200a014c43a9d69e9/webapp.png"
          },
          "title" => "Screenshot: Contentful web app"
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:20.144Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "4CWJDjGTzaU8CMAW2eYeie",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:20.144Z"
        }
      },
      %{
        "fields" => %{
          "file" => %{
            "contentType" => "image/svg+xml",
            "details" => %{
              "image" => %{"height" => 303, "width" => 496},
              "size" => 26_022
            },
            "fileName" => "json-presentation-layer.svg",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/1PzXR2apawY8iYM4o0AUoi/ceeea75d0bfda16a424b4801011b9b7d/json-presentation-layer.svg"
          },
          "title" => "Diagram: JSON delivered multi platform"
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:20.153Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "1PzXR2apawY8iYM4o0AUoi",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:20.153Z"
        }
      },
      %{
        "fields" => %{
          "description" => "A screenshot of Contentful's field validations UI.",
          "file" => %{
            "contentType" => "image/png",
            "details" => %{
              "image" => %{"height" => 1234, "width" => 1812},
              "size" => 215_648
            },
            "fileName" => "validations.png",
            "url" => "//images.ctfassets.net/wf4wl3wo9c3x/6n41KgxfwWmmeCiSemIsK2/9338f3929a49ffd0aaa56a34fb327a4d/validations.png"
          },
          "title" => "Screenshot: web app validations"
        },
        "sys" => %{
          "createdAt" => "2018-06-02T11:11:20.162Z",
          "environment" => %{
            "sys" => %{
              "id" => "master",
              "linkType" => "Environment",
              "type" => "Link"
            }
          },
          "id" => "6n41KgxfwWmmeCiSemIsK2",
          "locale" => "en-US",
          "revision" => 1,
          "space" => %{
            "sys" => %{
              "id" => "wf4wl3wo9c3x",
              "linkType" => "Space",
              "type" => "Link"
            }
          },
          "type" => "Asset",
          "updatedAt" => "2018-06-02T11:11:20.162Z"
        }
      }
    ]
  end  

  def entry do
     %{
    "fields" => %{
      "modules" => [
        %{
          "sys" => %{
            "id" => "4qT1W3HXewc0SscAs80UuA",
            "linkType" => "Entry",
            "type" => "Link"
          }
        },
        %{
          "sys" => %{
            "id" => "6gFiJvssqQ62CMYqECOu2M",
            "linkType" => "Entry",
            "type" => "Link"
          }
        },
        %{
          "sys" => %{
            "id" => "3UVMv9wHuw4auWMQ0qSamY",
            "linkType" => "Entry",
            "type" => "Link"
          }
        }
      ],
      "slug" => "content-model",
      "title" => "Content model"
    },
    "sys" => %{
      "contentType" => %{
        "sys" => %{
          "id" => "lesson",
          "linkType" => "ContentType",
          "type" => "Link"
        }
      },
      "createdAt" => "2018-06-02T11:11:13.324Z",
      "environment" => %{
        "sys" => %{
          "id" => "master",
          "linkType" => "Environment",
          "type" => "Link"
        }
      },
      "id" => "5p9qNpTOJaCE6ykC4a8Wqg",
      "locale" => "en-US",
      "revision" => 1,
      "space" => %{
        "sys" => %{
          "id" => "wf4wl3wo9c3x",
          "linkType" => "Space",
          "type" => "Link"
        }
      },
      "type" => "Entry",
      "updatedAt" => "2018-06-02T11:11:13.324Z"
    }
  }
  end

  def another_entry do
    %{
      "fields" => %{
        "copy" => "## API-first\n\nContentful follows an API-first approach, which means that all of its functionality is provided by an API.\n\nThis enables you to:\n\n- Modify
data schemas or configure a webhook through the Content Management API\n- Deliver cross-channel content through the Content Delivery API\n- Preview unpublished content through the Content Preview API\n- Resize, crop, or re-compress images through the Images API\n\n![api first](//images.contentful.com/qz0n5cdakyl9/1YK5kwroV6UEGS64mQs0Eo/c19b700d5c8d0f44b758c4b2bb79c586/contentful-four-apis.svg)\n\nContentful is a content infrastructure, so there is no templating or presentation layer tied to the content. Instead, a developer has
total freedom when it comes to the build of an application that consumes and presents content from Contentful. This also allows you to decouple your applications from Contentful's services.\n\nContentful has minimal requirements:\n\n- Support for HTTP\n- Parsing of JSON\n\nBeyond that, you are free to choose any technology you want.",
        "title" => "APIs > copy"
      },
      "sys" => %{
        "contentType" => %{
          "sys" => %{
            "id" => "lessonCopy",
            "linkType" => "ContentType",
            "type" => "Link"
          }
        },
        "createdAt" => "2018-06-02T11:11:15.131Z",
        "environment" => %{
          "sys" => %{
            "id" => "master",
            "linkType" => "Environment",
            "type" => "Link"
          }
        },
        "id" => "7iCSSldqDuUkG4GWa46uUq",
        "locale" => "en-US",
        "revision" => 1,
        "space" => %{
          "sys" => %{
            "id" => "wf4wl3wo9c3x",
            "linkType" => "Space",
            "type" => "Link"
          }
        },
        "type" => "Entry",
        "updatedAt" => "2018-06-02T11:11:15.131Z"
      }
    }

  end
    
  def third_entry do
      %{
      "fields" => %{
        "slug" => "application-development",
        "title" => "Application development"
      },
      "sys" => %{
        "contentType" => %{
          "sys" => %{
            "id" => "category",
            "linkType" => "ContentType",
            "type" => "Link"
          }
        },
        "createdAt" => "2018-06-02T11:11:15.147Z",
        "environment" => %{
          "sys" => %{
            "id" => "master",
            "linkType" => "Environment",
            "type" => "Link"
          }
        },
        "id" => "7JhDodrNmwmwGmQqiACW4",
        "locale" => "en-US",
        "revision" => 1,
        "space" => %{
          "sys" => %{
            "id" => "wf4wl3wo9c3x",
            "linkType" => "Space",
            "type" => "Link"
          }
        },
        "type" => "Entry",
        "updatedAt" => "2018-06-02T11:11:15.147Z"
      }
    }
  end

  def fourth_entry do
    %{
      "fields" => %{
        "copy" => "New to APIs? An API token ensures that only an authorized person or application can pull content from your space.",
        "title" => "SDK basics > SDK initialization - API token tip"
      },
      "sys" => %{
        "contentType" => %{
          "sys" => %{
            "id" => "lessonCopy",
            "linkType" => "ContentType",
            "type" => "Link"
          }
        },
        "createdAt" => "2018-06-02T11:11:15.147Z",
        "environment" => %{
          "sys" => %{
            "id" => "master",
            "linkType" => "Environment",
            "type" => "Link"
          }
        },
        "id" => "3k6uoYm9i8MycCm42IsY62",
        "locale" => "en-US",
        "revision" => 1,
        "space" => %{
          "sys" => %{
            "id" => "wf4wl3wo9c3x",
            "linkType" => "Space",
            "type" => "Link"
          }
        },
        "type" => "Entry",
        "updatedAt" => "2018-06-02T11:11:15.147Z"
      }
    }
  end

  def fifth_entry do
    %{
      "fields" => %{
        "copy" => "To make communication with Contentful as simple as possible, we've created open source SDKs.\n\nInstall an SDK:",
        "title" => "SDK basics > installation"
      },
      "sys" => %{
        "contentType" => %{
          "sys" => %{
            "id" => "lessonCopy",
            "linkType" => "ContentType",
            "type" => "Link"
          }
        },
        "createdAt" => "2018-06-02T11:11:15.595Z",
        "environment" => %{
          "sys" => %{
            "id" => "master",
            "linkType" => "Environment",
            "type" => "Link"
          }
        },
        "id" => "3Y1JQg9bjqIG6OgA2KAM4A",
        "locale" => "en-US",
        "revision" => 1,
        "space" => %{
          "sys" => %{
            "id" => "wf4wl3wo9c3x",
            "linkType" => "Space",
            "type" => "Link"
          }
        },
        "type" => "Entry",
        "updatedAt" => "2018-06-02T11:11:15.595Z"
      }
    }
  
  end  


  test "Can extract fields from a content type" do
    
    commands = transformed_entry(%Commands{},  entry())
    

    assert (length(commands.nodes) == 1)
    assert (length(commands.relationships) == 5)
  end

  test "Can extract fields from a another content type" do
    
    commands = transformed_entry(%Commands{},  another_entry())
    
    assert (length(commands.nodes) == 1)
    assert (length(commands.relationships) == 2)
  end

  test "Can extract fields from a third content type" do
    
    commands = transformed_entry(%Commands{},  third_entry())
    
    assert (length(commands.nodes) == 1)
    assert (length(commands.relationships) == 2)
  end



  test "Can transform asset" do

    [asset] = assets() |> Enum.take(1)
    command = transformed_asset(asset)
    ^command = %Neo4jQuery{params: %{idParam: "6nvWJT1AkM64so8Auue4QQ", titleParam: "Contentful hero", typeParam: "Asset", urlParam: "//images.ctfassets.net/wf4wl3wo9c3x/6nvWJT1AkM64so8Auue4QQ/3b21f3ce6654e2cbe42be91d9077d274/EngineeringHistory.png"}, query: "CREATE (a:asset {cmsid: {idParam}, cmstype: {typeParam}, title: {titleParam}, url: {urlParam}} ) RETURN a"}
  end  

end
