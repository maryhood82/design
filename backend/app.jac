import os;
import from dotenv {load_dotenv}
import from datetime {datetime, timedelta}
import from uuid {uuid4}
import from utils {get_current_datetime, get_current_date, get_current_month}
# import from ai_integration {
#     extract_article_from_url,
#     extract_article_from_text,
#     extract_article_from_image_file,
#     analyze_article_with_ai,
#     summarize_article,
#     classify_article_bias,
#     detect_article_language,
#     evaluate_article_credibility,
#     score_article_misinformation,
#     generate_article_alerts,
#     extract_keywords_from_article,
#     answer_natural_language_query,
#     generate_article_title,
#     detect_misinformation_in_article,
#     validate_credibility_score,
#     format_bias_category
# }

glob env_loaded = load_dotenv();
    
# Enums
enum BiasCategory {
    FACTUAL = "Factual",
    BALANCED= "Balanced",
    SUBJECTIVE= "Subjective Influence",
    UNBALANCED = "Unbalanced",
    UNFAIR = "Unfair",
    MISLEADING = "Misleading",
    FALSE= "False",
    UNKNOWN = "Unknown"
}

enum Language {
    EN = "English",
    FR = "French",
    DE = "German",
    RU = "Russian",
    NL = "Dutch"

}

enum Topics {
    ENTERTAINMENT = "Entertainment",  
    BUSINESS = "Business",
    HEALTH = "Health",
    LIFESTYLE = "Lifestyle",
    SPORTS= "Sports",
    TECHNOLOGY = "Technology",
    POLITICS = "Politics",
    SCIENCE = "Science",
    WORLD = "World",
}

# Nodes

node User{
    has user_name: str;
    has email: str;
    has password: str; 
    has created_at: str;
    has role: str = "";  # roles: superuser, administrator, user
    has is_active: bool = True;
}

node Preferences{
    has Topic: Topic;
    has Source: Source;
    has language: Language;
    has user: User;
}

node Article{
    has article_id: str;
    has title: str;
    has content: str;
    has created_at: str;
    has created_by: User;
    has source: Source;
    has date: str;
    has time: str;
    has summary: str;
    has bias: BiasCategory;
    has alerts: list[str];
    has topic: Topic;
    has language: Language;
    has url: str = "";
    has rss_feed: str = "";
    has credibility_pct: float = 0.0;
    has misinformation_score: float = 0.0;
    has analyzed: bool = False;
}

node Source{
    has source_id: str;
    has name: str;
    has created_at: str;
    has bias: BiasCategory;
    has language: Language;
    has created_by: User;
    has description: str = "";
    has url: str = "";
    has credibility_pct: float = 50.0;
    has is_active: bool = True;
}

node Topic{
    has topic_id: str;
    has name: str;
    has keywords: list[str];
    has created_at: str;
    has created_by: User;
    has description: str = "";
    has article_count: int = 0;
}

node Language{
    has language_id: str;
    has name: str;
    has code: str;  # ISO language code
    has created_at: str;
    has created_by: User;
}

walker init_graph {
    has user_name: str = "admin";
    has password: str = "admin123";
    has role: str = "superuser";

    can create_graph with root entry {
        # Create user node
        user_node = User(
            user_name = self.user_name,
            email = self.user_name + "@news.com",
            password = self.password,
            role = self.role,
            is_active = True,
            created_at = get_current_datetime()
        );

        # Create default language nodes
        english_lang = Language(
            language_id = "en",
            name = "English",
            code = "EN",
            created_at = get_current_datetime(),
            created_by = user_node
        );

        french_lang = Language(
            language_id = "fr",
            name = "French",
            code = "FR",
            created_at = get_current_datetime(),
            created_by = user_node
        );

        german_lang = Language(
            language_id = "de",
            name = "German",
            code = "DE",
            created_at = get_current_datetime(),
            created_by = user_node
        );

        russian_lang = Language(
            language_id = "ru",
            name = "Russian",
            code = "RU",
            created_at = get_current_datetime(),
            created_by = user_node
        );

        dutch_lang = Language(
            language_id = "nl",
            name = "Dutch",
            code = "NL",
            created_at = get_current_datetime(),
            created_by = user_node
        );

        # Create default topic nodes
        entertainment_topic = Topic(
            topic_id = "entertainment",
            name = "Entertainment",
            keywords = ["celebrity", "movies", "music", "tv", "gaming"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "Entertainment news and media"
        );

        business_topic = Topic(
            topic_id = "business",
            name = "Business",
            keywords = ["economy", "finance", "stocks", "companies", "market"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "Business and financial news"
        );

        health_topic = Topic(
            topic_id = "health",
            name = "Health",
            keywords = ["medical", "disease", "treatment", "wellness", "research"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "Health and medical news"
        );

        lifestyle_topic = Topic(
            topic_id = "lifestyle",
            name = "Lifestyle",
            keywords = ["food", "travel", "fashion", "home", "relationships"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "Lifestyle and culture news"
        );

        sports_topic = Topic(
            topic_id = "sports",
            name = "Sports",
            keywords = ["football", "basketball", "baseball", "soccer", "athletes"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "Sports news and events"
        );

        technology_topic = Topic(
            topic_id = "technology",
            name = "Technology",
            keywords = ["tech", "innovation", "gadgets", "software", "internet"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "Technology and innovation news"
        );

        politics_topic = Topic(
            topic_id = "politics",
            name = "Politics",
            keywords = ["government", "election", "policy", "law", "international"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "Political news and government"
        );

        science_topic = Topic(
            topic_id = "science",
            name = "Science",
            keywords = ["research", "discovery", "space", "environment", "study"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "Science and research news"
        );

        world_topic = Topic(
            topic_id = "world",
            name = "World",
            keywords = ["international", "global", "foreign", "diplomacy", "events"],
            created_at = get_current_datetime(),
            created_by = user_node,
            description = "World news and international events"
        );

        report {
            "message": "Graph initialized with default user, languages, and topics",
            "user": user_node.user_name,
            "languages_created": 5,
            "topics_created": 9
        };

    }
}

walker create_user {
    has user_name: str;
    has email: str;
    has password: str; 

    can add_to_user with root entry {
        visit User;
    }

    can create with User entry {
        # Create user node
        new_user = User(
            user_name = self.user_name,
            email = self.email,
            password = self.password,
            role = "user",
            is_active = True,
            created_at = get_current_datetime()
        );
        
        report {
            "message": "User added successfully",
            "user": new_user.user_name
        };
    }
}

walker login_user{
    has email: str;
    has password: str;
    has user_found: bool = False;
    has success: bool = False;
    can authenticate with root entry {
        visit User;
        if not self.user_found {
            report {
                "success": False,
                "message": "No users registered"
            };
        } elif not self.success {
            report {
                "success": False,
                "message": "Invalid email or password"
            };
        }
    }

    can check_credentials with User entry {
        self.user_found = True;
        if (here.email == self.email or here.user_name == self.email) and here.password == self.password {
            if here.is_active {
                self.success = True;
                report {
                    "success": True,
                    "message": "Login successful",
                    "user": {
                        "name": here.user_name,
                        "email": here.email,
                        "role": here.role,
                        "created_at": here.created_at
                    }
                };
            } else {
                report {
                    "success": False,
                    "message": "Account is disabled. Contact administrator."
                };
            }
        } else {
            visit User;
        }
    }
}


walker get_dashboard_data {
    can fetch_data with root entry {
        visit User;
    }

    can get_articles with User entry {
        total_articles = 0.0;
        topic_breakdown = {};
        
        # Simplified dashboard data
        report {
            "total_articles": total_articles,
            "topic_breakdown": topic_breakdown
        };
    }
}

walker get_articles_by_topic {
    has topic_name: str;
    can fetch_articles with root entry {
        visit User;
    }

    can get_articles with User entry {
        articles = [];
        # Simplified - return empty for now
        report {
            "topic": self.topic_name,
            "count": len(articles),
            "articles": articles
        };
    }
}







walker register_user {

    has name: str;
    has email: str;
    has password: str;

    can check_existing_user with root entry {
        visit User;
    }

    can find_user with User entry { 
        if here.email == self.email {
            report {
                "success": False,
                "message": "Email already registered"
            };
        } else {
            visit User;
        }
    }

    can create_user with root exit {
        new_user = User(
            user_name = self.name,
            email = self.email,
            password = self.password,
            role = "user",
            is_active = True,
            created_at = get_current_datetime()
        );

        report {
            "success": True,
            "message": "User registered successfully",
            "user": {
                "name": new_user.user_name,
                "email": new_user.email,
                "role": new_user.role,
                "created_at": new_user.created_at
            }
        };
    }
}

walker logout_user {
    has email: str;

    can perform_logout with `root entry{
        # In a real application, you'd handle session/token invalidation here
        report {
            "success": True,
            "message": f"User {self.email} logged out successfully"
        };
    }
}

walker reset_user_password {
    has email: str;
    has new_password: str;

    can find_user with root entry {
        visit User;
    }
    
    can update_password with User entry {
        if here.email == self.email {
            here.password = self.new_password;
            report {
                "success": True,
                "message": "Password reset successfully"
            };
        } else {
            visit User;
        }
    }

    can user_not_found with root entry {
        report {
            "success": False,
            "message": "User not found"
        };
    }
}


walker get_user_by_email {

     has email: str;

    can find_user with root entry {
        visit User;
    }

    can check_user with User entry {
        if here.email == self.email {
            report {
                "success": True,
                "user": {
                    "name": here.user_name,
                    "email": here.email,
                    "role": here.role,
                    "is_active": here.is_active,
                    "created_at": here.created_at
                }
            };
        } else {
            visit User;
        }
    }
    
    can user_not_found with root exit {
        report {
            "success": False,
            "message": "User not found"
        };
    }
}

walker update_user_role {

    has email: str;
    has new_role: str;  # "user", "administrator", "superuser"
    has admin_email: str;  # Email of admin making the change

    can verify_admin with root entry {
        visit User;
    }
    can check_admin_permissions with User entry {
        if here.email == self.admin_email and here.role == "superuser" {
            # Admin verified, now find target user
            visit User;
        } else {
            visit User;
        }
    }
    can update_role with User entry {
        if here.email == self.email {
            here.role = self.new_role;
            report {
                "success": True,
                "message": f"User role updated to {self.new_role}",
                "user": {
                    "name": here.user_name,
                    "email": here.email,
                    "role": here.role
                }
            };
        } else {
            visit User;
        }
    }

    can unauthorized with root entry {
        report {
            "success": False,
            "message": "Unauthorized: Only superuser can update roles"
        };
    }
}


walker toggle_user_status {

    has email: str;
    has admin_email: str;
    has is_active: bool;

    can verify_admin with root entry {
        visit User;
    }

    can check_admin_permissions with User entry {
        if here.email == self.admin_email and here.role == "superuser" {
            visit User;
        } else {
            visit User;
        }
    }

    can update_status with User entry {
        if here.email == self.email {
            here.is_active = self.is_active;
            status_text = "enabled" if self.is_active else "disabled";
            report {
                "success": True,
                "message": f"User account {status_text}",
                "user": {
                    "name": here.user_name,
                    "email": here.email,
                    "is_active": here.is_active
                }
            };

        } else {
            visit User;
        }
    }

    can unauthorized with root entry {
        report {
            "success": False,
            "message": "Unauthorized: Only superuser can change user status"
        };
    }
}


walker change_password {

    has email: str;
    has old_password: str;
    has new_password: str;

    can find_user with root entry {
        visit User;
    }

    can verify_and_update with User entry {
        if here.email == self.email {
            if here.password == self.old_password {
                here.password = self.new_password;
                report {
                    "success": True,
                    "message": "Password changed successfully"
                };
            } else {
                report {
                    "success": False,
                    "message": "Current password is incorrect"
                };
            }
        } else {
            visit User;
        }
    }

    can user_not_found with root exit {
        report {
            "success": False,
            "message": "User not found"
        };
    }
}

walker reset_password {

    has email: str;
    has new_password: str;

    can find_user with root entry {
        visit User;
    }

    can update_password with User entry {
        if here.email == self.email {
            here.password = self.new_password;
            report {
                "success": True,
                "message": "Password reset successfully"
            };
        } else {
            visit User;
        }
    }

    can user_not_found with root exit {
        report {
            "success": False,
            "message": "User not found"
        };
    }
}

walker get_all_users {

    has admin_email: str;
    has is_admin: bool = False;
    has all_users: list = [];

    can verify_admin with root entry {
        visit User;
    }
 
    can check_admin with User entry {
        if here.email == self.admin_email and here.role == "superuser" {
            self.is_admin = True;
        }
    }

    can collect with root entry {
        if self.is_admin {
            visit User;
            report {
                "success": True,
                "users": self.all_users,
                "count": len(self.all_users)
            };
        } else {
            report {
                "success": False,
                "message": "Unauthorized: Only superuser can view all users"
            };
        }
    }

    can collect_users with User entry {
        self.all_users.append({
            "name": here.user_name,
            "email": here.email,
            "role": here.role,
            "is_active": here.is_active,
            "created_at": here.created_at
        });
    }
}

walker get_user_preferences {

    has email: str;

    can find_user with root entry {
        visit User;
    }

    can get_preferences with User entry {
        if here.email == self.email {
            # Simplified - assume preferences are attached
            report {
                "success": True,
                "preferences": {
                    "topics": [],
                    "sources": []
                }
            };
        } else {
            visit User;
        }
    }

    can user_not_found with root exit {
        report {
            "success": False,
            "message": "User not found"
        };
    }
}

walker update_user_preferences {

    has email: str;
    has topics: list[str] = [];
    has sources: list[str] = [];
    has language: Language = Language.EN;

    can find_user with root entry {
        visit User;
    }

    can update_prefs with User entry {
        if here.email == self.email {
            # Simplified update
            report {
                "success": True,
                "message": "Preferences updated successfully"
            };
        } else {
            visit User;
        }
    }
}


walker flag_article {

    has article_id: str;
    has user_email: str;
    has reason: str;

    can find_article with root entry {
        visit Article;
    }

    can add_flag with Article entry {
        if here.article_id == self.article_id {
            flag_text = f"Flagged by {self.user_email}: {self.reason}";
            here.alerts.append(flag_text);
            report {
                "success": True,
                "message": "Article flagged successfully"
            };
        } else {
            visit Article;
        }
    }
    can article_not_found with root exit {
        report {
            "success": False,
            "message": "Article not found"
        };
    }
}


walker get_all_topics{

    can fetch_topics with root entry {
        all_topics = [];
        for topic in Topic {
            all_topics.append({
                "topic_id": topic.topic_id,
                "name": topic.name,
                "description": topic.description,
                "keywords": topic.keywords,
                "article_count": topic.article_count,
                "created_at": topic.created_at
            });
        }

        report {
            "success": True,
            "topics": all_topics,
            "count": len(all_topics)
        };
    }
}

walker add_source {

    has name: str;
    has description: str;
    has url: str;
    has bias: str;  # BiasCategory value
    has language: str;  # Language value
    has admin_email: str;

    can verify_admin with root entry {
        visit User;
    }

    can check_permissions with User entry {
        if here.email == self.admin_email and (here.role == "administrator" or here.role == "superuser") {
            # Create source
            source_id = str(uuid4());
            new_source = Source(
                source_id = source_id,
                name = self.name,
                description = self.description,
                url = self.url,
                bias = BiasCategory[self.bias.upper().replace(" ", "_")],
                language = Language[self.language.upper()],
                created_by = here,
                created_at = get_current_datetime(),
                is_active = True
            );

            report {
                "success": True,
                "message": "Source added successfully",
                "source": {
                    "source_id": source_id,
                    "name": self.name,
                    "url": self.url
                }
            };
        } else {
            report {
                "success": False,
                "message": "Unauthorized: Only administrators can add sources"
            };
        }
    }
}


walker edit_source{

    has source_id: str;
    has name: str;
    has description: str;
    has url: str;
    has bias: str;
    has language: str;
    has admin_email: str;

    can verify_admin with root entry {
        visit User;
    }

    can check_permissions with User entry {
        if here.email == self.admin_email and (here.role == "administrator" or here.role == "superuser") {
            # Find source
            visit Source;
        } else {
            report {
                "success": False,
                "message": "Unauthorized: Only administrators can edit sources"
            };
        }
    }

    can update_source with Source entry {
        if here.source_id == self.source_id {
            here.name = self.name;
            here.description = self.description;
            here.url = self.url;
            here.bias = BiasCategory[self.bias.upper().replace(" ", "_")];
            here.language = Language[self.language.upper()];

            report {
                "success": True,
                "message": "Source updated successfully",
                "source": {
                    "source_id": here.source_id,
                    "name": here.name
                }
            };
        } else {
            visit Source;
        }
    }

    can source_not_found with root exit {
        report {
            "success": False,
            "message": "Source not found"
        };
    }
}

walker toggle_source_status{

    has source_id: str;
    has is_active: bool;
    has admin_email: str;

    can verify_admin with root entry {
        visit User;
    }

    can check_permissions with User entry {
        if here.email == self.admin_email and (here.role == "administrator" or here.role == "superuser") {
            visit Source;
        } else {
            report {
                "success": False,
                "message": "Unauthorized"
            };
        }
    }

    can update_status with Source entry {
        if here.source_id == self.source_id {
            here.is_active = self.is_active;
            status_text = "enabled" if self.is_active else "disabled";
            report {
                "success": True,
                "message": f"Source {status_text}"
            };
        } else {
            visit Source;
        }
    }
}



walker get_all_sources{

    can fetch_sources with root entry {
        all_sources = [];
        for source in Source {
            all_sources.append({
                "source_id": source.source_id,
                "name": source.name,
                "description": source.description,
                "url": source.url,
                "bias": source.bias.value,
                "language": source.language.value,
                "credibility_pct": source.credibility_pct,
                "is_active": source.is_active,
                "created_at": source.created_at
            });
        }

        report {
            "success": True,
            "sources": all_sources,
            "count": len(all_sources)
        };
    }
}

walker add_topic{

    has name: str;
    has description: str;
    has keywords: list[str];
    has admin_email: str;

    can verify_admin with root entry {
        visit User;
    }

    can check_permissions with User entry {
        if here.email == self.admin_email and (here.role == "administrator" or here.role == "superuser") {
            topic_id = str(uuid4());
            new_topic = Topic(
                topic_id = topic_id,
                name = self.name,
                description = self.description,
                keywords = self.keywords,
                created_by = here,
                created_at = get_current_datetime(),
                article_count = 0
            );

            report {
                "success": True,
                "message": "Topic added successfully",
                "topic": {
                    "topic_id": topic_id,
                    "name": self.name
                }
            };
        } else {
            report {
                "success": False,
                "message": "Unauthorized: Only administrators can add topics"
            };
        }
    }
}


walker edit_topic{

    has topic_id: str;
    has name: str;
    has description: str;
    has keywords: list[str];
    has admin_email: str;

    can verify_admin with root entry {
        visit User;
    }

    can check_permissions with User entry {
        if here.email == self.admin_email and (here.role == "administrator" or here.role == "superuser") {

            visit Topic;
        } else {
            report {
                "success": False,
                "message": "Unauthorized"
            };
        }
    }

    can update_topic with Topic entry {
        if here.topic_id == self.topic_id {
            here.name = self.name;
            here.description = self.description;
            here.keywords = self.keywords;

            report {
                "success": True,
                "message": "Topic updated successfully"
            };
        } else {
            visit Topic;
        }
    }
}

walker get_all_topics{
        
    can fetch_topics with root entry{
        all_topics = [];
        for topic in Topic {
            all_topics.append({
                "topic_id": topic.topic_id,
                "name": topic.name,
                "description": topic.description,
                "keywords": topic.keywords,
                "article_count": topic.article_count,
                "created_at": topic.created_at
            });
        }
        
        report {
            "success": True,
            "topics": all_topics,
            "count": len(all_topics)
        };
    }
}

walker get_all_articles{

    has topic: str = "";
    has source: str = "";
    has bias: str = "";

    can fetch_articles with root entry {
        all_articles = [];

        for article in Article {
            # Apply filters
            if self.topic and article.topic.value != self.topic {
                continue;
            }
            if self.source and article.source.name != self.source {
                continue;
            }
            if self.bias and article.bias.value != self.bias {
                continue;
            }

            all_articles.append({
                "article_id": article.article_id,
                "title": article.title,
                "content": article.content,
                "summary": article.summary,
                "source": article.source.name,
                "topic": article.topic.value,
                "bias": article.bias.value,
                "language": article.language.value,
                "credibility_pct": article.credibility_pct,
                "misinformation_score": article.misinformation_score,
                "alerts": article.alerts,
                "url": article.url,
                "created_at": article.created_at,
                "author": article.created_by.user_name
            });
        }

        report {
            "success": True,
            "articles": all_articles,
            "count": len(all_articles)
        };
    }
}


